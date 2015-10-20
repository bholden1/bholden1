classdef gameAdversarial<Game
    %GAMEADVERSARIAL This is a concrete class defining a game where rewards
    %   are adversarially chosen.

    methods
        
        function self = gameAdversarial()
            self.nbActions = 2;
            self.totalRounds = 1000;
            self.N = 0; % the current round counter is initialized to 0
            rep = floor(self.totalRounds/self.nbActions);
            pattern = eye(self.nbActions);
            self.tabR = repmat(pattern,1,rep);
            remain = mod(self.totalRounds,self.nbActions);
            if(remain>0)
                self.tabR = [self.tabR,pattern(:,1:remain)];
            end
        end
        
    end    
end

