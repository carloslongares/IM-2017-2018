function d = displayLoading(text,Title)

    
    d = dialog('Position',[300 300 250 75],'Name',Title);
    movegui(d,'center')
    txt = uicontrol('Parent',d,...
               'Style','text',...
               'Position',[20 12 210 40],...
               'String',text,...
               'FontSize',12);

end