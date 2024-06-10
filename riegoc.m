classdef riegoc < handle
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here

    properties(SetAccess = private)
        timers = [];
        tiempo = [];
        Hs = [];
    end

    methods (Hidden = true)
        function segmentos(obj)
            global a
            pinMode(a,2,'OUTPUT') %a
            pinMode(a,3,'OUTPUT') %b
            pinMode(a,4,'OUTPUT') %c
            pinMode(a,5,'OUTPUT') %d
            pinMode(a,6,'OUTPUT') %e
            pinMode(a,7,'OUTPUT') %f
            pinMode(a,8,'OUTPUT') %g
            pinMode(a,9,'OUTPUT') %p
            pinMode(a,10,'OUTPUT') %off de la bomba
        end

        function A(obj)
            global a
            %logica positiva
            digitalWrite(a,2,1) %a
            digitalWrite(a,3,1) %b
            digitalWrite(a,4,1) %c
            digitalWrite(a,5,0) %d
            digitalWrite(a,6,1) %e
            digitalWrite(a,7,1) %f
            digitalWrite(a,8,1) %g
            digitalWrite(a,9,0) %p
        end
        function UNO(obj)
            global a
            %logica positiva
            digitalWrite(a,2,0) %a
            digitalWrite(a,3,1) %b
            digitalWrite(a,4,1) %c
            digitalWrite(a,5,0) %d
            digitalWrite(a,6,0) %e
            digitalWrite(a,7,0) %f
            digitalWrite(a,8,0) %g
            digitalWrite(a,9,0) %p
        end
        function DOS(obj)
            global a
            %logica positiva
            digitalWrite(a,2,1) %a
            digitalWrite(a,3,1) %b
            digitalWrite(a,4,0) %c
            digitalWrite(a,5,1) %d
            digitalWrite(a,6,1) %e
            digitalWrite(a,7,0) %f
            digitalWrite(a,8,1) %g
            digitalWrite(a,9,0) %p
        end
        function TRES(obj)
            global a
            %logica positiva
            digitalWrite(a,2,1) %a
            digitalWrite(a,3,1) %b
            digitalWrite(a,4,1) %c
            digitalWrite(a,5,1) %d
            digitalWrite(a,6,0) %e
            digitalWrite(a,7,0) %f
            digitalWrite(a,8,1) %g
            digitalWrite(a,9,0) %p
        end
        function PUNTO(obj)
            global a
            %logica negativa
            digitalWrite(a,2,0) %a
            digitalWrite(a,3,0) %b
            digitalWrite(a,4,0) %c
            digitalWrite(a,5,0) %d
            digitalWrite(a,6,0) %e
            digitalWrite(a,7,0) %f
            digitalWrite(a,8,0) %g
            digitalWrite(a,9,1) %p
        end
        function OFF(obj)
            global a
            digitalWrite(a,10,1); %apagado de bomba
        end
    end
    methods (Hidden = false)
        function obj=grafica(obj)
            global dato;
            global times;
            global k;
            dato(k)=obj.Hs;
            times(k)=obj.tiempo;
            figure(1)
            plot(times,dato);
            grid on
        end
        function Settimes(obj,timer)
            obj.timers=timer;
        end
        function SetHumedad(obj,humedad)
            obj.Hs=humedad;
        end

        function Settime(obj,tiempos)
            obj.tiempo=tiempos;
        end
        function estados(obj)
            global a;
            global estado;
            global t;
            switch estado
                case 1
                    if (obj.Hs>=0) && (obj.Hs<30)
                        obj.segmentos(); %inicializa los puertos
                        if(t<=obj.timers(1))
                            obj.A
                            pause(1)
                            obj.PUNTO
                            pause(1)
                            obj.UNO
                            pause(1)
                        else
                            t=0;
                            pause(5);
                            obj.OFF;
                            pause(5)
                        end
                    else

                        estado=2;
                    end
                case 2
                    if (obj.Hs>=30) && (obj.Hs<=60)
                        obj.segmentos(); %inicializa los puertos
                        if(t<=obj.timers(2))
                            obj.A
                            pause(1)
                            obj.PUNTO
                            pause(1)
                            obj.DOS
                            pause(1)
                        else
                            t=0;
                            pause(5);
                            obj.OFF;
                            pause(5)
                        end
                    else

                        estado=3;
                    end
                case 3
                    if (obj.Hs>=60) && (obj.Hs<=100)
                        obj.segmentos(); %inicializa los puertos
                        if(t<=obj.timers(3))
                            obj.A
                            pause(1)
                            obj.PUNTO
                            pause(1)
                            obj.TRES
                            pause(1)
                        else
                            t=0;
                            pause(5);
                            obj.OFF;
                            pause(5)
                        end
                    else

                        estado=1;
                    end
            end
        end
        function obj=riegoc(T,H,Ts)
            obj.Settimes(T);
            obj.SetHumedad(H);
            obj.Settime(Ts);
        end
    end
end