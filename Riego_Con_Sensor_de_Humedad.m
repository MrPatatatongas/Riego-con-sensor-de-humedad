clc
clear all
global a;
global estado;
global t;
global dato;
global times;
global k;
Stop=1;
h=0;
ts=0;
t=0;
times=0;
dato=0;
estado=1;
k=1;
T=0;
figure(1)
uicontrol("Style","pushbutton","String","STOP","Callback","Stop=0")
t1=input('Dame el tiempo de la humedad baja:_');
t2=input('Dame el tiempo de la humedad media:_');
t3=input('Dame el tiempo de la humedad alta:_');
T=[t1 t2 t3];
r=riegoc(T,h,ts);
warndlg('Espere un momento!');
a=arduino('COM3')
warndlg('Placa acoplada!');
pinMode(a,10,'OUTPUT');
digitalWrite(a,10,1);
pause(5);
tic
while Stop
    digitalWrite(a,10,0);
    r.estados;
    t=t+1
    r.SetHumedad(h);
    r.Settime(ts);
    r.grafica;
    h=(1023-analogRead(a,0))*(100/1023);
    ts=toc;
    k=k+1;
end
delete(a)
delete(r)