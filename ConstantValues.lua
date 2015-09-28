Filename = "SMB1-1.state"                   -- vi sparar ett state i början på spelet så vi kan ladda om från start hela tiden --
ButtonNames = {                             -- vilka möjliga outputs vi har --
    "A",
    "B",
    "Up",
    "Down",
    "Left",
    "Right",
}
    
BoxRadius = 6                               -- hur stor hitbox för en tile --      
InputSize = (BoxRadius*2+1)*(BoxRadius*2+1) -- 

Inputs = InputSize+1                        -- hur många inputs vi har från världen --
Outputs = #ButtonNames                      -- hur många outputs vi har (beror på kontrollen)

Population = 300                            -- hur många genomer som får finnas för varje generation --

DeltaDisjoint = 2.0                         -- används för att bestämma hur stor skillnad det får vara mellan genomer för att de ska tillhöra samma ras --
DeltaWeights = 0.4                          -- används för att bestämma hur stor skillnad det får vara mellan genomer för att de ska tillhöra samma ras --
DeltaThreshold = 1.0                        -- används för att bestämma hur stor skillnad det får vara mellan genomer för att de ska tillhöra samma ras --
                                            -- deltadisjoints*SkillnadenILänkar + deltaWeights*skillnadenIVikter < Deltathreshold == samma ras --

StaleSpecies = 15                           -- Hur många generationer en ras inte behöver förbättra sitt maxFitness, över detta antal så tas rasen bort -- 

MutateConnectionsChance = 0.25              -- sannolikhet för att vi skall försöka ändra vikten på en länk --
PerturbChance = 0.90                        -- sannolikhet för att vikten skall modifiera nuvarande vikt eller slumpa helt ny vikt (används efter mutateconnectionschance) -- 
CrossoverChance = 0.75                      -- sannolikhet för att ett barn skall skapas av två genomer, annars kopieras bara en genom till barnet -- 
LinkMutationChance = 2.0                    -- sannolikhet för att en ny länk skall skapas mellan två noder -- 
BiasMutationChance = 0.40                   -- sannolikhet för att en länk skall skapas mellan den sista input-noden och en random-nod -- 
NodeMutationChance = 0.50                   -- sannolikhet för att en länk skall bli två med olika vikter --
DisableMutationChance = 0.4                 -- sannolikhet för att en länk skall blir inaktiv som är aktiv just nu och inte användas i simulationen --
EnableMutationChance = 0.2                  -- sannolikhet för att en länk skall bli aktiv från inaktiv och användas i simulationen --

StepSize = 0.1                              -- används när vi MODIFIERAR gamla vikter i pointMutate -- 
TimeoutConstant = 20                        -- hur länge mario får stå still innan vi avbryter nuvarande simulation -- 

MaxNodes = 1000000                          -- hur många noder som max får finnas i en Genome --