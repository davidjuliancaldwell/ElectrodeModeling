function adjacencyGrid = create_adjacency_grid(gridSize)

% gridSize = [m,n]

n = gridSize(1)*gridSize(2);
adjacencyGrid = zeros(n);


index = 1;
while index <= n
    if mod(index,gridSize(2)) ~= 0
        adjacencyGrid(index,index+1) = 1;
    end
    
    if mod(index-1,gridSize(2)) ~=0
        adjacencyGrid(index,index-1) = 1;
        
    end
    
    if index + gridSize(2) <= gridSize(2).^2
        adjacencyGrid(index,index+gridSize(2)) = 1;
    end
    
    if index - gridSize(2) > 0
        adjacencyGrid(index,index-gridSize(2)) = 1;
    end
    
    index = index + 1;
    
end

    
end

