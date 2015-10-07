classdef policyGWM < Policy
    %POLICYGWM This policy implementes GWM for the bandit setting.
    
    properties
        nbActions % number of bandit actions
        % Add more member variables as needed
        weights % weights for the bandit actions
        t % track the step number for eta updates
    end
    
    methods
        
        function init(self, nbActions)
            % Initialize any member variables
            self.nbActions = nbActions;
            self.weights = ones(1,nbActions);
            self.t = 1;
            % Initialize other variables as needed

        end
        
        function action = decision(self)
            % Choose an action according to multinomial distribution

        end
        
        function getReward(self, reward)
            % Update the weights
            eta = sqrt(log10(self.nbActions)/self.t);
            self.t = self.t + 1;
            % First we create the loss vector for GWM
            lossScalar = 1 - reward; % This is loss of the chosen action
            lossVector = zeros(1,self.nbActions);
            lossVector(self.lastAction) = lossScalar;
            % Do more stuff here using loss Vector
            self.weights = self.weights.*exp(-eta*lossVector);
        end        
    end
end

