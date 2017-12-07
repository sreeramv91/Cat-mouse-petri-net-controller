function y = Display_CatMouseImage( Current_MarkingState )

%   The uses the input as the current marking state.
%   The Red Displays the cat and the Blue displays the mouse.

%---------------------------------------------------------------------------%
%-----------------------------> Display node <------------------------------%
%---------------------------------------------------------------------------%

rectangle('Position',[0,0,10,10],'FaceColor','white','EdgeColor','black');
line([5,5],[10,9],'Linewidth',4);
line([5,5],[8,7],'Linewidth',4);
line([5,5],[6,4],'Linewidth',4);
line([5,5],[3,2],'Linewidth',4);
line([5,5],[1,0],'Linewidth',4);

line([10,9],[5,5],'Linewidth',4);
line([8,7],[5,5],'Linewidth',4);
line([6,4],[5,5],'Linewidth',4);
line([3,2],[5,5],'Linewidth',4);
line([1,0],[5,5],'Linewidth',4);
text(1,9,'ROOM 1');
text(8,9,'ROOM 2');
text(1,1,'ROOM 3');
text(8,1,'ROOM 4');

for i =1:4                          % the 1st 4 nodes are for the cat
    if(Current_MarkingState(i) == 1)
        room_number =i;
        break;
    end
end
switch(room_number)
    case 1                          % Room 1
        cat_x = 2;
        cat_y = 7.5;
    case 2                          % Room 2
        cat_x = 7.5;
        cat_y = 7.5;
    case 3                          % Room 3
        cat_x = 2;
        cat_y = 2;
    case 4                          % Room 4
        cat_x = 7.5;
        cat_y = 2;
end

for i =5:8                          % the nodes from 5 to 8 are for the mouse
    if(Current_MarkingState(i) == 1)
        room_number =i;
        break;
    end
end
switch(room_number)                 % to put in the coordinates for each room
    case 5                          % Room 1
        mouse_x = 2;
        mouse_y = 7.5;
    case 6                          % Room 2
        mouse_x = 7.5;
        mouse_y = 7.5;
    case 7                          % Room 3
        mouse_x = 2;
        mouse_y = 2;
    case 8                          % Room 4
        mouse_x = 7.5;
        mouse_y = 2;
end

rectangle('Position',[mouse_x,mouse_y,0.4,0.4],'FaceColor','blue','EdgeColor','black'); % Mouse pointer
rectangle('Position',[cat_x,cat_y,0.4,0.4],'FaceColor','red','EdgeColor','black');      % Cat Pointer

end

%-------------------------------------------------------------------------%
%-----------------------------------> End <-------------------------------%
%-------------------------------------------------------------------------%
