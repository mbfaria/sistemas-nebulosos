clear; clc; close all; rng(42);

%% Read data
data_iris = readtable('Iris.csv');
X = normc(table2array(data_iris(:, 2:end-1)));
y = table2array(data_iris(:, end));
y = grp2idx(y); % Set values to 0 and 1
y(y==2) = 0; y(y==3) = 0;

num_samples = length(y);

%% Fuzzy parameters 
type = 'sugeno';
num_cluster = 3; % num_rules
max_iter = 50;

%% Cross-validation parameters
percentage_test = .3;
num_folds = 5;

%% Training
accuracy_list = zeros(num_folds, 1);

for fold = 1:num_folds
    
    % Separate data in train and test sets
    c = cvpartition(num_samples,'Holdout', percentage_test);
    train_indexes = training(c);
    test_indexes = test(c);
    
    X_train = X(train_indexes, :);
    y_train = y(train_indexes);
    
    X_test = X(test_indexes, :);
    y_test = y(test_indexes);
    
    % Initalize anfis model with FCM
    FIS = genfis3(X_train, y_train, type, num_cluster);
    
    % Train anfis
    [FIS,ERROR,STEPSIZE]= anfis([X_train y_train], FIS, max_iter);
    
    % Plot train error
    fig = figure(fold);
    plot(1:length(ERROR), ERROR, 'k')
    title('Error in fold ' + string(fold));
    ylabel('Error');
    xlabel('Iteration')
    saveplot(fig, 'images/iris_error_fold_' + string(fold))

    
    % Calculate test results
    y_predict = evalfis(FIS, X_test);
    y_predict_binary = truncate(y_predict, 0.5);
    accuracy = length(find(y_test==y_predict_binary))/length(y_test);
    accuracy_list(fold) = accuracy;
end

mean_accuracy = mean(accuracy_list)
std_accuracy = std(accuracy_list)





