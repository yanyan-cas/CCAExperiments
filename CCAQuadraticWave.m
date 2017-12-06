function stateOutput = CCAQuadraticWave(neighborState, LastNeighborState, WavePara, Nonlinearity)

    
    sEast = neighborState(2, 1);
    sWest = neighborState(2, 3);
    sNorth = neighborState(1, 2);
    sSouth = neighborState(3, 2);
    stateNE = neighborState(1, 1);
    stateNW = neighborState(1, 3);
    stateSW = neighborState(3, 3);
    stateSE = neighborState(3, 1);
    
    stateCurrent = neighborState(2, 2);
    statePast = LastNeighborState(2,2);
    stateAverage = (sEast + sWest + sSouth + sNorth + 0.75 * (stateNE + stateNW + stateSW + stateSE)) / 7;
    %stateTimeAverage = (stateCurrent + statePast) / 2;
    
    % The diffusion parameter ranges  from 0 to unity, the weightbi shifts
    % from the cell to its neighbors Diffusion > 1 leads to instability
    stateOutput = (2* stateCurrent - statePast) + 2 * WavePara * (stateAverage - stateCurrent + ...
         Nonlinearity * ((stateEast - stateCurrent)^2 - (stateCurrent - sWest)^2 + (stateNorth - stateCurrent)^2 - (stateCurrent - sSouth) ^2);
    

end