clear all 
close all

array = {};

for i=1:6
   array{i} = sprintf('%s%d','let_right_',i); 
   array{i+6} = sprintf('%s%d','let_left_',i); 
   array{i+12} = sprintf('%s%d','let_both_',i); 
   array{i+18} = sprintf('%s%d','ori_right_',i); 
   array{i+24} = sprintf('%s%d','ori_left_',i); 
   array{i+30} = sprintf('%s%d','ori_both_',i); 
end

array = array';

array2 = [1 2 3 4 5];

filename = 'array.xls';
xlswrite(filename,array{1});