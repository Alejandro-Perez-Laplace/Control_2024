% Parámetros del sistema original
K = 12.7767; % Ganancia del controlador
sensor_gain = 6.36; % Ganancia del sensor

% Numeradores y denominadores de los sistemas
num_sensor = sensor_gain;
den_sensor = 1;

num_proceso = 0.28;
den_proceso = 5;

num_dinamica = 1;
den_dinamica = [3.5 1];

% Aproximación de Padé de primer orden para el retardo Td
num_pade1 = [1 -0.6];
den_pade1 = [1 0.6];

% Crear las funciones de transferencia del proceso
G_proceso = tf(num_proceso, den_proceso);
G_dinamica = tf(num_dinamica, den_dinamica);
G_pade1 = tf(num_pade1, den_pade1);
G_sensor = tf(num_sensor, den_sensor);

% Sistema en lazo abierto sin compensador
G_open = K * G_proceso * G_dinamica * G_pade1;

% Sistema en lazo cerrado sin compensador (realimentado por el sensor)
G_closed = feedback(G_open, G_sensor);

% Mostrar polos y ceros del sistema original sin compensador
[z, p, k] = zpkdata(G_closed, 'v');
disp('Ceros del sistema sin compensador:');
disp(z);
disp('Polos del sistema sin compensador:');
disp(p);

% Parámetros del compensador de adelanto
zero_c = [-6]; % Ajustar el cero del compensador
pole_c = [-5]; % Ajustar el polo del compensador

% Crear la función de transferencia del compensador de adelanto
G_compensador_adelanto = tf([1 -zero_c],[1 -pole_c]);


% Sistema en lazo abierto con compensador de adelanto
G_open_with_compensator = K * G_compensador_adelanto * G_proceso * G_dinamica * G_pade1;

% Sistema en lazo cerrado con compensador de adelanto y realimentación del sensor
G_closed_with_compensator = feedback(G_open_with_compensator, G_sensor);

% Obtener los ceros, polos y ganancia del sistema con compensador
[z_compensado, p_compensado, k_compensado] = zpkdata(G_closed_with_compensator, 'v');

% Mostrar ceros y polos del sistema compensado
disp('Ceros del sistema con compensador de adelanto:');
disp(z_compensado);
disp('Polos del sistema con compensador de adelanto:');
disp(p_compensado);

% Graficar los polos y ceros en el plano cartesiano con compensador
figure;
pzmap(G_closed_with_compensator); % Gráfico en el plano s
grid on;
title('Diagrama de polos y ceros del sistema realimentado con compensador de adelanto');
xlabel('Parte real');
ylabel('Parte imaginaria');
axis equal; % Escala igual para ambos ejes

% Graficar la respuesta al escalón del sistema con compensador
figure;
step(G_closed_with_compensator); % Gráfico de la respuesta al escalón
grid on;
title('Respuesta al escalón del sistema realimentado con compensador de adelanto');
xlabel('Tiempo (segundos)');
ylabel('Amplitud');

% Graficar el diagrama de Bode de amplitud y fase del sistema sin y con compensador
figure;
bode(G_closed); % Gráfico de Bode sin compensador
hold on;
bode(G_closed_with_compensator); % Gráfico de Bode con compensador
grid on;
legend('Sin compensador', 'Con compensador');
title('Diagrama de Bode del sistema realimentado (sin y con compensador de adelanto)');
hold off;
