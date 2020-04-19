clear,clc
% defining options for clarity in printing later
% keep this order consistent throughout the process
option(1) = "MPLab PIC32";
option(2) = "Vorago VA10820";
option(3) = "Microchip STK600";

% defining Matrices
                     % IDE Radiation   Space  Processor Price
                     %     Protection  Proven   Speed        
% IDE                   #      #         #        #       #  % look at [2,1]
% Radiation Protection  2      #         #        #       #  % Radiation Protection is 2x more preferred than IDE
% Space Proven          #      #         #        #       #  
% Processor Speed       #      #         #        #       #  
% Price                 #      #         #        #       #  
% Memory Size           #      #         #        #       #  
criteriaMatrix=[  1  1/7  1/3  1/4    2; 
                  7    1    2    5    6; 
                  3  1/2    1    3    5;
                  4  1/5  1/3    1    2;
                1/2  1/6  1/5  1/2    1];

                  % MPLab PIC32  Vorago VA10820 Microchip STK600
% MPLab PIC32            #             #                 #      % look at [2,1]
% Vorago VA10820         6             #                 #      % Vorago VA10820 is 6x more preferred than MPLab PIC32
% Microchip STK600       #             #                 #

% 1: IDE
% MPLab ATSAM4E-EK = Yes, very nice with in circuit debugger capabilities
% Vorago REB1-VA10820 = No, just command line
% Microchip ATSTK600-ND = Yes, with multiple debug add ons
CriteriaComparisonMatrix(:,:,1)=[  1   5    2; 
                                 1/5   1  1/4; 
                                 1/2   4    1];
% 2: Radation Protection
% MPLab ATSAM4E-EK = no radiation protection
% Vorago REB1-VA10820 = radiation hardened 
% Microchip ATSTK600-ND = radiation tolerant
CriteriaComparisonMatrix(:,:,2)=[  1 1/9  1/5;
                                   9   1    3;
                                   5 1/3    1];
% 3: Space Proven
% MPLab ATSAM4E-EK = Yes, in LEO
% Vorago REB1-VA10820 = Yes, In LEO 
% Microchip ATSTK600-ND = No
CriteriaComparisonMatrix(:,:,3)=[  1   5    5;
                                 1/5   1    1;
                                 1/5   1    1];
% 4: Processing Speed
% MPLab ATSAM4E-EK = up to 120MHz
% Vorago REB1-VA10820 = 50MHz 
% Microchip ATSTK600-ND = 8MHz
CriteriaComparisonMatrix(:,:,4)=[  1   3    5;
                                 1/3   1    4;
                                 1/5 1/4    1];
% 5: Price
% MPLab ATSAM4E-EK = $278.99
% Vorago REB1-VA10820 = $730
% Microchip ATSTK600-ND = $215.06
CriteriaComparisonMatrix(:,:,5)=[  1   4     2;
                                 1/4   1   1/4;
                                 1/2   4     1];

% preallocating arrays
priorityVecMatrix=zeros(length(CriteriaComparisonMatrix(:,:,1)),length(criteriaMatrix));
consistencyIndex=zeros(length(CriteriaComparisonMatrix),1);

% finding priority vectors and consistency indices
priorityVec=PriorityVector(criteriaMatrix);
criteriaConsistency=ConsistencyIndex(criteriaMatrix);

for i=1:length(CriteriaComparisonMatrix)
   priorityVecMatrix(:,i)=PriorityVector(CriteriaComparisonMatrix(:,:,i));
   consistencyIndex(i)=ConsistencyIndex(CriteriaComparisonMatrix(:,:,i));
   if consistencyIndex(i)>.1
       error('Criteria Comparison Matrix %i is not consistent with a consistency %d>.1 \n',i,consistencyIndex(i));
   end
end
% priorityVecMatrix
% priorityVec
winner=priorityVecMatrix*priorityVec;

% printing the results
for i = 1:length(winner)
    fprintf(option(i) + ": " + winner(i) + "\n"); 
end
