num1 = [1 -0.6]; % Numerador sistema pade 1º
den1 = [1 0.6]; % Denominador pade 1º
Pade1 = tf(num1, den1); % Función de transferencia
% Aproximación de Padé de segundo orden


num2 = [1 -0.6 0.12]; % Numerador pade 2º
den2 = [1 0.6 0.12]; % Denominador pade 2º
Pade2 = tf(num2, den2); % Función de transferencia Pade2

Td = 1.2; % tiempo de retardo
K = 12.7767; % ganancia unitaria
num =K * (3.5/5) * (6.36);
den = [Td 1]; % denominador considerando el retardo

sys = tf(num, den); % función de transferencia sistema

% Graficar las respuestas al escalón
figure;
step(Pade1); hold on;
step(Pade2); hold on;
step(sys); % respuesta al escalón
grid on;