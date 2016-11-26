module Handler.Recipe where

import Import

getRecipeR :: RecipeId -> Handler Value
getRecipeR recipeId = do
    recipe <- runDB $ get404 recipeId
    return $ object ["recipe" .= Entity recipeId recipe]

putRecipeR :: RecipeId -> Handler Value
putRecipeR recipeId = do
    recipe <- requireJsonBody :: Handler Recipe
    insertedRecipe <- runDB $ replace recipeId recipe
    sendResponseStatus status200 ("UPDATED" :: Text)

deleteRecipeR :: RecipeId -> Handler Value
deleteRecipeR recipeId = do
    runDB $ delete recipeId
    sendResponseStatus status200 ("DELETED" :: Text)
