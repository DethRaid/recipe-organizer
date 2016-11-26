module Handler.StepList where

import Import

postStepListR :: Handler Value
postStepListR = do
    stepList <- requireJsonBody :: Handler StepList
    insertedStepList <- runDB $ insertEntity stepList
    returnJson insertedStepList
