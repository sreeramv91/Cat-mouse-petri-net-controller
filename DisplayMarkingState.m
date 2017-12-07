function [y] = DisplayMarkingState( Current_MarkingState,PresentEnabledTransitions,t )
%DISPLAYMARKINGSTATE Summary of this function goes here
%   Detailed explanation goes here

    EnabledTransitionCount = t;
    fprintf('Marking state [%d %d %d %d %d %d %d %d %d %d %d %d]',...
        Current_MarkingState(1),Current_MarkingState(2),Current_MarkingState(3),Current_MarkingState(4),...
        Current_MarkingState(5),Current_MarkingState(6),Current_MarkingState(7),Current_MarkingState(8),...
        Current_MarkingState(9),Current_MarkingState(10),Current_MarkingState(11),Current_MarkingState(12));
    fprintf('Enabled transition');
    for i =1:EnabledTransitionCount
        
        switch(PresentEnabledTransitions(i))
            case 1
                fprintf(' C1');
            case 2
                fprintf(' C2');
            case 3
                fprintf(' C3');
            case 4
                fprintf(' C4');
            case 5
                fprintf(' M1');
            case 6
                fprintf(' M2');
            case 7
                fprintf(' M3');
            case 8
                fprintf(' M4');
        end
        
    end
    fprintf('\n');
end

