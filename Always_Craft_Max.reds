// Meeflak
// Version 1.0


// ALWAYS CRAFT MAX AMMO
// This mod sets ammo to always be crafted to the max ammount. 
// Combined with my XML edit, this allows the user to instantly replenish ammo
// without needing to wait for the hold animation to finish and without selecting
// the max ammount of ammo. 



@replaceMethod(CraftingLogicController)
  protected cb func OnHoldFinished(evt: ref<ProgressBarFinishedProccess>) -> Bool {
    let quantity: Int32;
    if !this.m_isPanelOpen {
      return false;
    };

    if this.m_selectedRecipe.id.TagsContains(n"Grenade") || this.m_selectedRecipe.id.TagsContains(n"Consumable") || this.m_selectedRecipe.id.TagsContains(n"Ammo") || Equals(InventoryItemData.GetItemType(this.m_selectedRecipe.inventoryItem), gamedataItemType.Gen_CraftingMaterial) {
      quantity = this.m_craftingSystem.GetMaxCraftingAmount(InventoryItemData.GetGameItemData(this.m_selectedItemData));
      
      if this.m_selectedRecipe.id.TagsContains(n"Ammo") && quantity == 0 {
        return false;
      };

      if quantity > 1 && ! this.m_selectedRecipe.id.TagsContains(n"Ammo") {
        this.OpenQuantityPicker(this.m_selectedItemData, quantity);
        return true;
      };
    };

    if this.m_selectedRecipe.id.TagsContains(n"Ammo") {
      this.CraftItem(this.m_selectedRecipe, quantity);
    } else {
      this.CraftItem(this.m_selectedRecipe, this.m_selectedRecipe.amount);
    };
  }
