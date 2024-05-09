this1 = [1 2 3; 4 5 6];
this2 = [7 8 9; 10 11 12];
this3 = [];
this4 = [1 2 3];
this5 = [1 2 3];
this6 = [1 2 3];

that = [];

% The eval function will execute a command within a given string
m = 0;
for k=1:2
    for i=1:2
        m=m+1;
        for j=1:3
            eval(sprintf('that(m,j) = this%d(i,j)', k));
        end
    end
end

% eval('1+1');