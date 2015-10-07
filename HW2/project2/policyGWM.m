classdef policyGWM < Policy
    %POLICYGWM This policy implementes GWM for the bandit setting.
    
    properties
        nbActions % number of bandit actions
        % Add more member variables as needed
        weights % weights for the bandit actions
        t % track the step number for eta updates
        lastAction % last action taken
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
            % Create the distribution
            normWeights = self.weights./sqrt(sum(self.weights.^2));
            pdf = zeros(1,self.nbActions);
            for i = 1:self.nbActions
                for j = 1:i
                    pdf(1,i) = pdf(1,i) + normWeights(j);
                end
            end
            % Sample from the distribution
            sample = rand;
            % Choose an action according to multinomial distribution
            for i = self.nbActions:-1:1
                if(sample <= pdf(1,i))
                    action = i;
                end
            end
            self.lastAction = action;
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

