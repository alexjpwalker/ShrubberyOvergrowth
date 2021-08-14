include("ClimateScreen");

BASE_TabSelectOverview = TabSelectOverview;

function TabSelectOverview()
	BASE_TabSelectOverview();

	local shrubberyChance : number = GameClimate.GetFirePercentChance() * 4;
	local shrubberyIncrease : number = GameClimate.GetFireClimateIncreasedChance() * 4;

	Controls.ShrubberyActivityChanceNum:SetText(Locale.Lookup("LOC_CLIMATE_PERCENT_CHANCE", shrubberyChance));
	Controls.ShrubberyChanceFromClimateChange:SetText( Locale.Lookup("LOC_CLIMATE_AMOUNT_FROM_CLIMATE_CHANGE", shrubberyIncrease)  );	
end
