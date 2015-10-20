classdef gameLookupTable < Game
    %GAMELOOKUPTABLE This is a concrete class defining a game defined by an
    %external input
    
    methods
        function self = gameLookupTable(tabInput, isLoss)
            % Input
            %   tabInput - input table (actions x rewards or losses)
            %   isLoss - 1 if input table represent loss, 0 otherwise
            data = load(tabInput,'-mat');
            vars = fieldnames(data);
            table = data.(vars{1});
            [self.nbActions, self.totalRounds] = size(table);
            if(isLoss)
                self.tabR = 1 - table;
            else
                self.tabR = table;
            end
            self.N = 0;
        end
        
    end
    
end
