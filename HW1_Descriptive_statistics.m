% Tarea 1: Estadísticos descriptivos
% Por rivel_co

clear, clc

%% Load the data
table = readtable("dbs\waittimes.csv");
data = table2array(table);

%%  Now calculate centality statistics
data_n = size(data,1);
data_mean = mean(data);
data_median = median(data);
data_mode = mode(data);
%-----------------
fprintf('Estadísticos de centralidad\n')
fprintf('Cantidad de datos: %.4f\n', data_n)
fprintf('Media de los datos: %.4f\n', data_mean)
fprintf('Mediana de los datos: %.4f\n', data_median)
fprintf('Moda de los datos: %.4f\n', data_mode)

%% Quantiles 
data_q1 = quantile(data, 0.25);
data_q2 = quantile(data, 0.50);
data_q3 = quantile(data, 0.75);
%-----------------
fprintf('\nEstadísticos de posición\n')
fprintf('Cuartil 1 (Q1): %.4f\n', data_q1)
fprintf('Cuartil 2 (Q2): %.4f\n', data_q2)
fprintf('Cuartil 3 (Q3): %.4f\n', data_q3)

%% Dispersion
data_stddev = std(data);
data_var = var(data);
data_range = max(data) - min(data);
data_range_q = data_q3 - data_q1;
data_cv = data_stddev / data_mean;
%-----------------
fprintf('\nEstadísticos de dispersión\n')
fprintf('Desviación estándar de la media: %.4f\n', data_stddev)
fprintf('Varianza de los datos: %.4f\n', data_var)
fprintf('Rango de los datos: %.4f\n', data_range)
fprintf('Rango intercuartílico de los datos: %.4f\n', data_range_q)
fprintf('Coeficiente de variación de los datos: %.4f\n', data_cv)

%% Shape
data_skewness = skewness(data);
data_kurtosis = kurtosis(data);
%-----------------
fprintf('\nEstadísticos de forma\n')
fprintf('Skewness de los datos: %.4f\n', data_skewness)
fprintf('Kurtosis de los datos: %.4f\n', data_kurtosis)

%% Create histogram
data_hist_bins = round(sqrt(data_n));
figure(1)
histfit(data, data_hist_bins)
title('Histograma de frecuencias de waittimes')

%% Create the Tukey diagram
figure(2)
% Calculate the whisker range 
iqr = diff([data_q1, data_q2, data_q3]);
w = 1.5;
whisker_range = [max(min(data), data_q1 - w*iqr), min(max(data), data_q3 + w*iqr)];
boxplot(data)
title('Diagrama de Tukey');
text(1.1, data_q1, sprintf('<- Q1: %.4f', data_q1), 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
text(1.1, data_q2, sprintf('<- Q2: %.4f', data_q2), 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
text(1.1, data_q3, sprintf('<- Q3: %.4f', data_q3), 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
text(1.1, whisker_range(1), sprintf('<- Eje inferior: %.4f', whisker_range(1)), 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
text(1.1, 2*whisker_range(2), sprintf('<- Eje superior: %.4f', whisker_range(2)), 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
text(1.1, min(data) + 0.3, sprintf('<- Valores extremos'), 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top');
text(1.1, max(data) - 0.3, sprintf('<- Valores extremos'), 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top');

set(gcf, 'Color', 'w');
set(gca, 'LineWidth', 1.5, 'FontName', 'Helvetica', 'FontSize', 12);
xlabel('Wait times');
ylabel('Time');