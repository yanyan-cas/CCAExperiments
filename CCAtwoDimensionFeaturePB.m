function nextImageState = CCAtwoDimensionFeaturePB(inputMatrix, DiffusionPara)
    [m, n] = size(inputMatrix);
    seed = inputMatrix;   
    nextImageState = zeros(m, n);
    
    
%%
% calculate the next state for the Periodic-boundary cells -- central part
for i = 2 : m-1
    for j = 2 : n-1
        % get the neighbor cells' states
        temp = [ seed(i-1, j-1),  seed(i-1, j),   seed(i-1, j+1);...
                        seed(i, j-1),     seed(i, j), seed(i, j+1); ...
                        seed(i+1, j-1), seed(i+1, j) , seed(i+1, j+1)];
        nborState = temp;
%         temp = [1, 2, 3, 4 , 5, 6, 7, 8, 9];
%         nborState = reshape(temp', 3, 3);
%          % get the next state
        nextImageState(i, j) = CCAstateDiffusion(nborState, DiffusionPara);        
    end
end

%%
% calculate the next state for the Periodic-boundary cells -- first row
for i = 1
    for j = 1 : n
        % get the neighbor cells' states - for Periodic_Boundary the neighbor
        % cells' states are 0
        switch j         
            case 1
                 temp = [  seed(i, j),               seed(m, j),               seed(m, j+1); ...
                                 seed(i, n),         seed(i, j),     seed(i, j+1); ...
                                 seed(i+1, n),         seed(i+1, j) , seed(i+1, j+1) ];               
            case n
                 temp = [  seed(m, j-1),                      seed(m, j),              seed(i, j); ...
                        seed(i, j-1),     seed(i, j),           seed(i, 1); ...
                        seed(i+1, j-1), seed(i+1, j) ,       seed(i+1, 1)];                    
            otherwise   
                temp = [ seed(m, j-1),   seed(m, j),     seed(m, j+1); ...
                        seed(i, j-1),     seed(i, j), seed(i, j+1); ...
                        seed(i+1, j-1), seed(i+1, j) , seed(i+1, j+1) ];    
        end
        nborState = temp;
         % get the next state             
       nextImageState(i, j) = CCAstateDiffusion(nborState, DiffusionPara);  
    end    
end
    
%%
% calculate the next state for the Non-boundary cells -- LAST row
for i = m
    for j = 1 : n
      % get the neighbor cells' states - for Periodic_Boundary the neighbor
        % cells' states are 0
        switch j         
            case 1
                 temp = [ seed(i-1,n),        seed(i-1, j),   seed(i-1, j+1); ...
                               seed(i, n),           seed(i, j),      seed(i, j+1);...
                               seed(i,j) ,                 seed(1, j) ,                       seed(1, j+1) ];                 
            case n
                 temp = [ seed(i-1, j-1),  seed(i-1, j),   seed(i-1, 1);...
                        seed(i, j-1),     seed(i, j),              seed(i, 1);...
                             seed(1, j-1),                 seed(1, j) ,                       seed(i, j) ];                   
            otherwise   
                temp = [  seed(i-1, j-1),  seed(i-1, j),   seed(i-1, j+1); ...
                        seed(i, j-1),     seed(i, j), seed(i, j+1);...
                               seed(1, j-1),                seed(1, j),               seed(i, j)];    
        end
        nborState = temp;
         % get the next state             
       nextImageState(i, j) = CCAstateDiffusion(nborState, DiffusionPara);     
       
    end
end
    
%%
% calculate the next state for the Non-boundary cells -- first column and
% last column

for i = 2 : m -1
    for j = [1 n]
          % get the neighbor cells' states
          if j == 1
        temp = [ seed(i-1, n),  seed(i-1, j),   seed(i-1, j+1);...
                        seed(i, n),     seed(i, j), seed(i, j+1); ...
                        seed(i+1, n), seed(i+1, j) , seed(i+1, j+1) ];    
          else 
                % get the neighbor cells' states
        temp = [ seed(i-1, j-1),  seed(i-1, j),   seed(i-1, 1); ...
                        seed(i, j-1),     seed(i, j), seed(i, 1); ...
                        seed(i+1, j-1), seed(i+1, j) , seed(i+1, 1) ];    
          end
            nborState = temp;
         % get the next state             
       nextImageState(i, j) = CCAstateDiffusion(nborState, DiffusionPara);     
    end
end

end
