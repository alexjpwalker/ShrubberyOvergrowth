local TutorialLoader = {};
table.insert(g_TutorialLoaders, TutorialLoader);

-- ===========================================================================
function TutorialLoader:Initialize(TutorialCheck:ifunction)	
	if (GameCapabilities.HasCapability("CAPABILITY_MEGADISASTERS")) then
		-- Register game core events
		local iPlayerID : number = Game.GetLocalPlayer();
		if (iPlayerID < 0) then
			return;
		end

		local pPlayer = Players[iPlayerID];

		Events.RandomEventOccurred.Add(function (eEventType:number, eSeverity:number, locX:number, locY:number)
			local localPlayerID = Game.GetLocalPlayer();
			if (player == localPlayerID) then
				local tmpEvent = GameInfo.RandomEvents["RANDOM_EVENT_SHRUBBERY"];
				if tmpEvent ~= nil and eEventType == tmpEvent.Index then
					TutorialCheck("ShrubberyEvent");
				end
			end
		end);
	end
end

-- ===========================================================================
function TutorialLoader:CreateTutorialItems(AddToListener:ifunction)
	local item = TutorialItem:new("SHRUBBERY_EVENT");
	item:SetRaiseEvents("ShrubberyEvent");		
	item:SetTutorialLevel(TutorialLevel.LEVEL_EXPERIENCED_PLAYER);
	item:SetIsEndOfChain(true);
	item:SetIsQueueable(true);
	item:SetShowPortrait(true);
	item:SetAdvisorMessage("LOC_TUTORIAL_SHRUBBERIES");
	item:SetAdvisorAudio("Play_ADVISOR_LINE_FTUE_GENERAL_1");
	item:AddAdvisorButton("LOC_ADVISOR_BUTTON_CONTINUE",
		function( advisorInfo )
			UI.PlaySound("Stop_ADVISOR_LINE_FTUE_GENERAL_1");
			LuaEvents.AdvisorPopup_ClearActive( advisorInfo );
		end );
	item:AddAdvisorButton("LOC_ADVISOR_BUTTON_TELL_ME_MORE",
		function(advisorInfo)
			LuaEvents.OpenCivilopedia("CONCEPTS", "ENVIRONMENTAL_EFFECTS")
			LuaEvents.AdvisorPopup_ClearActive(advisorInfo)
			UI.PlaySound("Stop_ADVISOR_LINE_FTUE_GENERAL_1");
		end);
	item:SetIsDoneFunction(
		function()
			return false;
		end );
	AddToListener("ShrubberyEvent", item);
end
