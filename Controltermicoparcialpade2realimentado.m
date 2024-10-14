% Definir la ganancia del controlador y el sensor
K = 12.7767; % Ganancia del controlador
sensor_gain = 0.00636; % Ganancia del sensor
% Numeradores y denominadores de los sistemas
num_sensor = sensor_gain;
den_sensor = 1;

num_proceso = 0.28;
den_proceso = 0.005;

num_dinamica = 1;
den_dinamica = [3.5 1];

% Aproximación de Padé de segundo orden
num_pade2 = [1 -0.6 0.12];
den_pade2 = [1 0.6 0.12];

% Crear las funciones de transferencia
G_proceso = tf(num_proceso, den_proceso);
G_dinamica = tf(num_dinamica, den_dinamica);

G_pade2 = tf(num_pade2, den_pade2);
G_sensor = tf(num_sensor, den_sensor);

% Sistema en lazo abierto
G_open = K * G_proceso * G_dinamica * G_pade2;

% Sistema en lazo cerrado con realimentación del sensor
G_closed = feedback(G_open, G_sensor);

% Obtener los ceros, polos y ganancia del sistema en lazo cerrado
[z, p, k] = zpkdata(G_closed, 'v');

% Mostrar ceros y polos
disp('Ceros del sistema');
disp(z);
disp('Polos del sistema');
disp(p);

% Graficar los polos y ceros en el plano cartesiano
figure;
pzmap(G_closed); % Gráfico en el plano s
grid on;
title('Diagrama de polos y ceros del sistema realimentado');
xlabel('Parte real');
ylabel('Parte imaginaria');
axis equal; % Escala igual para ambos ejes

% Graficar la respuesta al escalón
figure;

step(G_closed); % Gráfico de la respuesta al escalón
grid on;
title('Respuesta al escalón del sistema realimentado');
xlabel('Tiempo (segundos)');
ylabel('Amplitud');