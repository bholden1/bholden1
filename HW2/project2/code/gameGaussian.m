classdef gameGaussian < Game
    %GAMEGAUSSIAN This is a concrete class defining a game where rewards a
    %   are drawn from a gaussian distribution.
    
    methods
        
        function self = gameGaussian(nbActions, totalRounds) 
            % Input
            %   nbActions - number of actions
            %   totalRounds - number of rounds of the game
            self.nbActions = nbActions;
            self.totalRounds = totalRounds;
            self.N = 0; % the current round counter is initialized to 0
            self.tabR = zeros(nbActions,totalRounds);
            for i = 1:nbActions
                mean = rand;
                sigma = rand;
                for j = 1:totalRounds
                    self.tabR(i,j) = normrnd(mean,sigma);
                    if(self.tabR(i,j) > 1)
                        self.tabR(i,j) = 1;
                    elseif(self.tabR(i,j) < 0)
                        self.tabR(i,j) = 0;
                    end
                end
            end
        end
        
    end    
end

