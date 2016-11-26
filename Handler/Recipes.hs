module Handler.Recipes where

import Import

getRecipesR :: Handler Value
getRecipesR = do
    recipes <- runDB $ selectList [] [] :: Handler [Entity Recipe]
    return $ object ["recipes" .= recipes]

postRecipesR :: Handler Value
postRecipesR = do
    recipe   <- requireJsonBody :: Handler Recipe
    recipeId <- runDB $ insert recipe
    sendResponseStatus status201 $ show recipeId