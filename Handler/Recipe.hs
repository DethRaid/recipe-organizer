module Handler.Recipe where

import Import

getRecipeR :: RecipeId -> Handler Value
getRecipeR recipeId = do
    maybeRecipe <- runDB $ get recipeId
    case maybeRecipe of
        Nothing -> notFound
        Just recipe -> returnJson recipe

putRecipeR :: RecipeId -> Handler Value
putRecipeR recipeId = do
    recipe <- requireJsonBody :: Handler Recipe
    insertedRecipe <- runDB $ insert recipe
    returnJson insertedRecipe

postRecipeR :: RecipeId -> Handler Value
postRecipeR _ = sendResponseStatus internalServerError500 $ RepJson "Not yet implimented"

deleteRecipeR :: RecipeId -> Handler Value
deleteRecipeR _ = sendResponseStatus internalServerError500 $ RepJson "Doesn't exist"
