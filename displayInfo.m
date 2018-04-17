function displayInfo(h,info)

close(h);
h=msgbox(['  Mini-batch Accuracy:  ' num2str(info.TrainingAccuracy(end)) '%'],'Info');
movegui(h,'center')


