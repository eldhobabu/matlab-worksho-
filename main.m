% User parameters
userWeight = 70; % User's weight (in kg)
MET_walking = 3.5; % Metabolic equivalent for walking

% Initialization
caloriesBurned = 0; % Burned calories (initial value)
samplingInterval = 1; % Sampling interval (in seconds)

% Connecting to the mobile device
mobile = mobiledev; % Initialize mobile device
mobile.AccelerationSensorEnabled = true; % Enable accelerometer
mobile.SpeedSensorEnabled = true; % Enable speed sensor

disp('Starting data collection...');
pause(2); % Delay for initialization

% Main loop
while true
    % Retrieve speed data
    speed = mobile.Speed; % Speed in m/s

    % Check for available data
    if ~isempty(speed) && speed > 0
        % Calculate the time interval (in minutes)
        duration = samplingInterval / 60;

        % Calculate burned calories
        calories = MET_walking * userWeight * duration * 0.0175;

        % Update the total calories burned
        caloriesBurned = caloriesBurned + calories;

        % Display the current result
        fprintf('Current speed: %.2f m/s\n', speed);
        fprintf('Burned calories: %.2f kcal\n', caloriesBurned);
    else
        disp('No speed data or user is stationary.');
    end

    % Pause before the next measurement
    pause(samplingInterval);
end
