% Parámetros del sistema
num1 = [1 -0.6]; % Numerador del sistema Padé de 1er orden
den1 = [1 0.6]; % Denominador del sistema Padé de 1er orden
Pade1 = tf(num1, den1); % Función de transferencia Padé de 1er orden

% Ganancia del controlador
K = 12.7767;

% Planta
num_plant = 0.28; % Numerador planta
den_plant = [3.5 1]; % Denominador planta
plant = tf(num_plant, den_plant);

% Sistema de realimentación
feedback_sys = feedback(K * plant * Pade1, 1); % Realimentación unitaria
negativa

% Sensor


% Graficar polos y ceros del sistema realimentado
figure;
pzmap(feedback_sys);
title('Polos y Ceros del Sistema Realimentado');

% Obtener valores de polos y ceros
polos_realimentado = pole(feedback_sys);
ceros_realimentado = zero(feedback_sys);

% Mostrar los valores de los polos y ceros en la consola
disp('Polos del sistema realimentado');
disp(polos_realimentado);

disp('Ceros del sistema realimentado');
disp(ceros_realimentado);