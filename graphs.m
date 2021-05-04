function [] = graphs()
close all; %closes possible open tabs

%name the global gui
global graphs;

%opens one figure in the middle of the screen
graphs.fig = figure('position', [350 125 600 450], 'numbertitle','off','name','Graphs');

%create a box that can take the X values
graphs.textX = uicontrol('style','text','position',[20 345 50 20],'string','Enter X:','horizontalalignment','right'); 
graphs.editX = uicontrol('style','edit','position',[80 350 100 20]);

%create a box that can take the Y values    
graphs.textY = uicontrol('style','text','position',[300 345 50 20],'string','Enter Y:','horizontalalignment','right');
graphs.editY = uicontrol('style','edit','position',[360 350 100 20]);


graphs.line = uicontrol('style','text','position',[20 300 50 25],'string','Line Type:','horizontalalignment','right');
%using radiobuttons for line type
lineType = uibuttongroup('units','normalized','Visible','on','position',[.13 .55 .25 .2],'SelectionChangedFcn',{@lineTypeFunction});%width from left,length from bottom,width of box,height 
graphs.rb1 = uicontrol(lineType,'HandleVisibility','on','style','radiobutton','position',[10 20 80 25],'string','Dotted');
graphs.rb2 = uicontrol(lineType,'HandleVisibility','on','style','radiobutton','position',[10 40 80 25],'string','Dashed');
graphs.rb3 = uicontrol(lineType,'HandleVisibility','on','style','radiobutton','position',[10 60 100 25],'string','Dashed-Dotted');

graphs.color = uicontrol('style','text','position',[20 200 50 25],'string','Color Type:','horizontalalignment','right');
%using radiobuttons for color type
colorType = uibuttongroup('units','normalized','Visible','on','position',[.13 .32 .25 .2],'SelectionChangedFcn',{@colorTypeFunction});%width from left,length from bottom,width of box,height 
graphs.rb4 = uicontrol(colorType,'HandleVisibility','on','style','radiobutton','position',[10 20 80 25],'string','Red');
graphs.rb5 = uicontrol(colorType,'HandleVisibility','on','style','radiobutton','position',[10 40 80 25],'string','Blue');
graphs.rb6 = uicontrol(colorType,'HandleVisibility','on','style','radiobutton','position',[10 60 80 25],'string','Black');

%X and Y axis titles
graphs.titleTextX = uicontrol('style','text','position',[0 385 75 30],'string','X Axis Title:','horizontalalignment','right'); 
graphs.titleEditX = uicontrol('style','edit','position',[80 400 100 20]);
graphs.titleTextY = uicontrol('style','text','position',[280 385 75 30],'string','Y Axis Title:','horizontalalignment','right'); 
graphs.titleEditY = uicontrol('style','edit','position',[360 400 100 20]);

%X and Y limits
graphs.limitTextX = uicontrol('style','text','position',[0 365 75 25],'string','X Limit:','horizontalalignment','right'); 
graphs.limitEditX = uicontrol('style','edit','position',[80 375 100 20]);
graphs.limitTextY = uicontrol('style','text','position',[280 365 75 25],'string','Y Limit:','horizontalalignment','right'); 
graphs.limitEditY = uicontrol('style','edit','position',[360 375 100 20]);

%graph title
graphs.nameText = uicontrol('style','text','position',[0 415 75 25],'string','Graph Title:','horizontalalignment','right'); 
graphs.nameEdit = uicontrol('style','edit','position',[80 425 100 20]);

%creates a graph in the figure
graphs.axes = axes('units','normalized','position',[.5 .2 .4 .5]);

%plot button
graphs.plot = uicontrol('style','pushbutton','position', [80 105 75 25], 'string', 'Plot','callback',{@plotGraph});

    function[] = plotGraph(source,event)
        global line;
        global color;
        x = graphs.editX.String;
        y = graphs.editY.String;
        x = split(x,',');
        y = split(y,',');
        x = cell2mat(x);
        y = cell2mat(y);
        x = str2num(x);
        y = str2num(y);
        
        i = checkLength(x,y);
        if i 
            return
        end
        
        plot(x,y,[color line])
        
        xlabel(graphs.titleEditX.String)
        ylabel(graphs.titleEditY.String)
        title(graphs.nameEdit.String)
        xlim(str2num(graphs.limitEditX.String));
        ylim(str2num(graphs.limitEditY.String));
        %input xlim with space inbetween values!!!
    end

%reset button        
graphs.reset = uicontrol('style','pushbutton','position',[80 75 75 25],'string', 'Reset','callback', {@resetFunction});

    %reset by clearing plot
     function [] = resetFunction(event, source)
         plot(0,0)
         %clear the edit boxes
         set(graphs.titleEditX,'String','');
         set(graphs.titleEditY,'String','');
         set(graphs.limitEditX,'String','');
         set(graphs.limitEditY,'String','');
         set(graphs.nameEdit,'String','');
         set(graphs.editX,'String','');
         set(graphs.editY,'String','');    
     end  

     %function to check is x and y are equal lengths
     function [error] = checkLength(x, y)
         error = false;
          if length(x) ~= length(y)
              msgbox('Incorrect Amount of Inputs!','Graphing Error','error','modal')
              error = true;
          end
     end  
    
end

%radio button function for line
function [] = lineTypeFunction(source,event)
    global line;
    if strcmp('Dotted',event.NewValue.String)
        line = '.';
    elseif strcmp('Dashed',event.NewValue.String)
        line = '--';
    elseif strcmp('Dashed-Dotted',event.NewValue.String)
        line = '-.';
    end    
end

%radio button function for color
function [] = colorTypeFunction(source,event)
    global color;
    if strcmp('Red',event.NewValue.String)
        color = 'r';
    elseif strcmp('Blue',event.NewValue.String)
        color = 'b';
    elseif strcmp('Black',event.NewValue.String)
        color = 'k';
    end    
end