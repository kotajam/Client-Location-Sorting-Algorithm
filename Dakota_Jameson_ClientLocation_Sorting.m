%% Created by Dakota Jameson
%% Date Finished: 11/30/2024

% Importing data from the excel spreadsheet
Mapping_data = readmatrix("Dakota_Jameson_Mapping_Data.xlsx");

% Filter the data through the algorithm based on the calling code of the country
Call_code = Mapping_data(:, 1); % Extracting the data from column 2 in the excel spreadsheet; the calling codes
elements = numel(Call_code); % Reading the number of elements within that array

% Declaring each major region as an array
AMER = []; 
APAC = [];
EMER = [];

for i = 1:elements % Essentially the MATLAB equivalent of an iterating for loop with a counter variable (something you would usually see in C)
    
    num1 = Call_code(i); % isolating the calling code
    string1 = num2str(num1); % Converting the numerical value to a character string
    first = str2double(string1(1)); % Isolating the first number of the calling code

    if first == 1 || first == 5 % For calling codes, the America region includes the the numbers 1 & 5. 1 represents North America, while 5 represents Central and South America
        
        AMER(end+1) = num1; % Adding a new index to the array and storing the value of num1 there. This sort of function is used when we are iterating across data and we cannot predict how many indicies we are going to need for the specified array

    elseif first == 6 || first == 8 % For the Asia-Pacific region, the numbers 6 & 8 are included. 6 represents southeast asia and Oceania, while 8 represents East Asia, South Asia, and special services
        
        APAC(end+1) = num1;

    else % For the Europe, Middle East, and Africa region, the numbers 2,3,4,7, & 9 are included. 2 represents mostly Africa. 3 and 4 represent all of Europe. 7 represents Russia and neighboring regions. 9 Represents West, Central, and South Asia
        
        EMER(end+1) = num1;

    end
end

% Converting all the arrays to column form to ensure correct formatting

AMER = AMER(:);
APAC = APAC(:);
EMER = EMER(:);

% Calculate the maximum length between all the arrays

MAX = max([length(AMER), length(APAC), length(EMER)]);

% Insert NaN values into the two smaller arrays so that the indicies of all
% three arrays are the same, making our data rectangular

AMER_boosted = [AMER; NaN(MAX - length(AMER), 1)]; % Why do we do this? Well, when exporting data from MATLAB to excel, we need rectangular data. Essentially, our data needs to be in the form of a rectangle. So, we are finding the maximum length of the largest array, and we are placing "NaN" values in the arrays of the other two smaller arrays, so that each array is the same length, creating a rectangle. This way, we can successfully export our data. The parts of the array that contain "NaN" data points will just turn blank in excel when exported.
APAC_boosted = [APAC; NaN(MAX - length(APAC), 1)];
EMER_boosted = [EMER; NaN(MAX - length(EMER), 1)];

% Combine the arrays 

combined = [AMER_boosted, APAC_boosted, EMER_boosted];

% Exporting the combined arrays to excel

writematrix(combined, 'Sorted Client Data.xlsx', 'Sheet', 1, 'Range', 'A1');

% Adding column headers

headers = {'AMER', 'APAC', 'EMER'}; % Header names
writecell(headers, 'Sorted Client Data.xlsx', 'Sheet', 1, 'Range', 'A1:C1');

fprintf('Data has been exported to Sorted Client Data.xlsx\n');