%%------------------------------->Example 1<-------------------------------%
% M0 = [1;0;0;1];
%Incident_Matrix =[-1 0 -1;1 0 0;1 -1 1;0 1 -1];
%Input_Incident_Matrix = [1 0 1;0 1 0;0 1 0;0 0 1];

%%------------------------------->Example 2<-------------------------------%
% M0 = [2;1;1];
% Incident_Matrix =[-2 0 0;0 -1 1;1 1 -1];
% Input_Incident_Matrix = [2 0 1;0 1 0;0 0 1];

clear all;close all;clc;


Incident_Matrix = [0 0 0 1 -1 -1 0 0 0 0 0 0;
    1 0 0 -1 0 1 0 0 0 0 0 0;
    0 1 -1 0 1 0 0 0 0 0 0 0;
    -1 -1 1 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 -1 1 0 0 0 1;
    0 0 0 0 0 0 1 -1 -1 0 0 0;
    0 0 0 0 0 0 0 0 0 1 -1 -1;
    0 0 0 0 0 0 0 0 1 -1 1 0;
    0 0 0 -1 1 1 1 -1 0 0 0 -1;
    -1 0 0 1 0 -1 -1 1 1 0 0 0;
    0 -1 1 0 -1 0 0 0 0 -1 1 1;
    1 1 -1 0 0 0 0 0 -1 1 -1 0;];

Input_Incident_Matrix = [0 0 0 0 1 1 0 0 0 0 0 0;
    0 0 0 1 0 0 0 0 0 0 0 0;
    0 0 1 0 0 0 0 0 0 0 0 0;
    1 1 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 1 0 0 0 0 0;
    0 0 0 0 0 0 0 1 1 0 0 0;
    0 0 0 0 0 0 0 0 0 0 1 1;
    0 0 0 0 0 0 0 0 0 1 0 0;
    0 0 0 1 0 0 0 1 0 0 0 1;
    1 0 0 0 0 1 1 0 0 0 0 0;
    0 1 0 0 1 0 0 0 0 1 0 0;
    0 0 1 0 0 0 0 0 1 0 1 0;];
M0 = [0;0;0;1;1;0;0;0;0;1;1;0];

MarkingState_Length = length(M0);
NumberofEnabledTransitions = 0;
mk_col = 0;
d = 0;
duplicate_flag =0;
fire_count = 0;
X = zeros(MarkingState_Length,1);

[Matrixsize_Row, Matrixsize_Column] = size(Input_Incident_Matrix);
Transition_disable_flag = 0;

%----------------------------------------------------------------------------%
% ----------> doing the 1st transition outside the while loop <--------------%
%----------------------------------------------------------------------------%

Current_MarkingState = M0;
Current_Transition = 0;
fire_count =0;
Display_CatMouseImage(Current_MarkingState);
pause(1)                                       % waiting for 1 second
t=0;
for j = 1:Matrixsize_Column                    % checking each transitions against the marking state
    Transition_disable_flag = 0;
    
    for i =1:Matrixsize_Row                    % checking each element in the transition against the marking state
        if ~(M0(i) >= Input_Incident_Matrix(i,j))
            Transition_disable_flag = 1;       % if B- matrix is greater flag is set and the element check in the transition is stopped
            break;
        end
    end
    if ~(Transition_disable_flag)              % To check if the transition is enabled
        
        NumberofEnabledTransitions = NumberofEnabledTransitions +1;
        Enabled_Transitions(NumberofEnabledTransitions) = j;     % The array of enabled transitions
        t=t+1;
        PresentEnabledTransitions(t) = j;
        
    end
    
    % if not duplicate or terminal.
    if ~(Transition_disable_flag)
        X = zeros(MarkingState_Length,1);
        X(Enabled_Transitions(NumberofEnabledTransitions)) = 1;
        mk_col = mk_col+1;
        mk(:,mk_col) = M0 + Incident_Matrix * X;        % creating an array of Marking States that need to be fired. Once mk = 0 the tree has reached completion
        
        
        
    else
        fire_count = fire_count+1;                      % If the fire count reaches the number of transitions in the net it means it reached the termianl node
    end
end
DisplayMarkingState( Current_MarkingState,PresentEnabledTransitions,t );
if(fire_count == MarkingState_Length)                   %Total no of transitions in the Petri Net
    disp('Terminal Node');
end
d= d+1;
Reachable_State(:,d) = M0;

%----------------------------------------------------------------------------%
% -----------------------> End of 1st transition <---------------------------%
%----------------------------------------------------------------------------%


while(~isempty(mk))
    
    Current_MarkingState = mk(:,NumberofEnabledTransitions);                 % Setting the Marking state as the latest in the array of Marking states
    Current_Transition = Enabled_Transitions(NumberofEnabledTransitions);    % The transition through which this state was obtained just for reference not used in code
    Display_CatMouseImage(Current_MarkingState);
    pause(1)                                                                 % waiting for 1 second
    mk(:,NumberofEnabledTransitions) = [];                                   % Removing the Current transition from the to be fired marking state
    Enabled_Transitions(NumberofEnabledTransitions) = [];                    % Removing the transition as well as it has been fired
    NumberofEnabledTransitions = NumberofEnabledTransitions - 1;             % reference to the last value in the mk array
    [Matrixsize_Row, Matrixsize_Column] = size(Input_Incident_Matrix);
    Transition_disable_flag = 0;                                             % flag set when transitions are not enabled after comparison with B-
    duplicate_flag = 0;                                                      % Enabled when there is a duplicate. Compared with the already available reachble states
    
    %----------------------------------------------------------------------------------------%
    %----------------> To check for the duplicates in the reachable states<------------------%
    %----------------------------------------------------------------------------------------%
    for i=1:d
        if(Current_MarkingState == Reachable_State(:,i))
            duplicate_flag = 1;
        end
    end
    %----------------------------------------------------------------------------------------%
    %----------------------------------------> END<------------------------------------------%
    %----------------------------------------------------------------------------------------%
    t=0;
    if ~(duplicate_flag)
        fire_count =0;
        
        %----------------------------------------------------------------------------------------%
        %-------------------------> Check for next enabled transition<---------------------------%
        %----------------------------------------------------------------------------------------%
        
        for j = 1:Matrixsize_Column                    % checking each transitions
            Transition_disable_flag = 0;
            for i =1:Matrixsize_Row                    % checking each element in the transition
                if ~(Current_MarkingState(i) >= Input_Incident_Matrix(i,j))
                    Transition_disable_flag = 1;       % if B- matrix is greater flag is set and the element check in the transition is stopped
                    break;
                end
            end
            if ~(Transition_disable_flag)
                NumberofEnabledTransitions = NumberofEnabledTransitions +1;
                Enabled_Transitions(NumberofEnabledTransitions) = j;     % The array of enabled transitions
                t=t+1;
                PresentEnabledTransitions(t) = j;
            end
            
            if ~(Transition_disable_flag)
                X = zeros(MarkingState_Length,1);        % Set a firing matrix X the size of the Marking State
                X(Enabled_Transitions(NumberofEnabledTransitions)) = 1;
                mk(:,NumberofEnabledTransitions) = Current_MarkingState + Incident_Matrix * X;
                
            else
                fire_count=fire_count+1;
            end
            
        end
        
        
        %----------------------------------------------------------------------------------------%
        %--------------------------------------> END <-------------------------------------------%
        %----------------------------------------------------------------------------------------%
        
        d= d+1;
        Reachable_State(:,d) = Current_MarkingState;
        DisplayMarkingState( Current_MarkingState,PresentEnabledTransitions,t );
        if(fire_count == MarkingState_Length)                               % no of transitions in the system
            fprintf('NO ENABLED STATES TERMINAL NODE\n\n\n');               % display for a terminal node
            
        end
        
    else
        fprintf('Marking state [%d %d %d %d %d %d %d %d %d %d %d %d]',...
            Current_MarkingState(1),Current_MarkingState(2),Current_MarkingState(3),Current_MarkingState(4),...
            Current_MarkingState(5),Current_MarkingState(6),Current_MarkingState(7),Current_MarkingState(8),...
            Current_MarkingState(9),Current_MarkingState(10),Current_MarkingState(11),Current_MarkingState(12));
        fprintf('DUPLICATE NODE\n');                                        % display for a duplicate node
    end
end

fprintf('The final reachable states in the order of firing: \n');
disp(Reachable_State);

