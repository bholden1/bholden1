classdef policyUCB < Policy
    %POLICYUCB This is a concrete class implementing UCB.

        
    properties
        % Member variables
        % Define member variables
        nbActions % number of bandit actions
        % Add more member variables as needed
        weights % weights for the bandit actions
        s % action total reward so far
        c % action counter
        t % track the step number
        lastAction % last action taken
    end
    
    methods
        function init(self, nbActions)
            % Initialize
            self.nbActions = nbActions;
            self.t = 1;
            self.s = zeros(1,nbActions);
            self.c = zeros(1,nbActions);
        end
        
        function action = decision(self)
            % Choose action
            for i = 1:self.nbActions
                if(self.c(i) == 0)
                    action = i;
                    self.lastAction = action;
                    return;
                end
            end
            [~,action] = max(self.s./self.c + sqrt(log(self.t)./(2*self.c)));
            self.lastAction = action;
        end
        
        function getReward(self, reward)
            % Update ucb
            self.s(self.lastAction) = self.s(self.lastAction) + reward;
            self.c(self.lastAction) = self.c(self.lastAction) + 1;
        end        
    end

end
