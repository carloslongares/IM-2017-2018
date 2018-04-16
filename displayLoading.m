function h = displayLoading(text,Title)


h=msgbox('',Title);
delete(findobj(h,'string','OK'));

try
   iconsClassName = 'com.mathworks.widgets.BusyAffordance$AffordanceSize';
   iconsSizeEnums = javaMethod('values',iconsClassName);
   SIZE_32x32 = iconsSizeEnums(2);  % (1) = 16x16,  (2) = 32x32
    jObj = com.mathworks.widgets.BusyAffordance(SIZE_32x32, text);  % icon, label
catch
    redColor   = java.awt.Color(1,0,0);
    blackColor = java.awt.Color(0,0,0);
    jObj = com.mathworks.widgets.BusyAffordance(redColor, blackColor);
end
jObj.setPaintsWhenStopped(true);  % default = false
jObj.useWhiteDots(false);         % default = false (true is good for dark backgrounds)
javacomponent(jObj.getComponent, [40,10,80,80], h);
jObj.start;
