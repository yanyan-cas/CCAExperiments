function state = CCAstateCalculate(neighborState, multPara, continousConstant)
    
    %state = mean(mean(neighborState)) + continousConstant;  %average
     temp = mean(mean(neighborState)) * multPara + continousConstant;
    state = (temp - floor(temp));
    

end