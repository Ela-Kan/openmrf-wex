% Author: Ela Kanani, based on code by: (15/05/2026)
% Maximilian Gram, University Hospital Wuerzburg, Wuerzburg, Germany; V1, 09.03.2026

%% add sequence objects for water exchange MRF

% init loop counters for contrast preparations
loop_INV    = 1;

% reset rf spoiling increment
loop_rf_inc = 0;  
   
for loop_MRF = 1 : MRF.n_segm
    % Label segment
    seq.addTRID(['MRFWEX_' num2str(loop_MRF) '_' MRF.enc_list{loop_MRF}]);
 
    % 1. Preparation (Inversion + TI)
    MRF_add_preparation();

    % 2. Readouts (ONLY the chunk for this segment)
    for loop_seg = 1 : SPI.rd_per_seg
        % Calculate global index correctly (1 to SPI.NR)
        loop_NR = (loop_MRF-1)*SPI.rd_per_seg + loop_seg;
        
        % Safety check: only add if the pulse exists
        if loop_NR <= SPI.NR
            SPI_add(); 
        end
    end
end