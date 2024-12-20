--RUM－七皇の剣
function c57734012.initial_effect(c)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,57734012+EFFECT_COUNT_CODE_OATH)
	e2:SetTarget(c57734012.target)
	e2:SetOperation(c57734012.activate)
	c:RegisterEffect(e2)
end
function c57734012.filter1(c,e,tp)
	local no=aux.GetXyzNumber(c)
	local ect=c29724053 and Duel.IsPlayerAffectedByEffect(tp,29724053) and c29724053[tp]
	return no and no>=101 and no<=107 and c:IsSetCard(0x48) and not c:IsSetCard(0x1048)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and (not ect or ect>1 or c:IsLocation(LOCATION_GRAVE))
		and Duel.IsExistingMatchingCard(c57734012.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,no)
end
function c57734012.filter2(c,e,tp,mc,no)
	return aux.GetXyzNumber(c)==no and c:IsSetCard(0x1048) and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
end
function c57734012.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local loc=0
	local ect=aux.ExtraDeckSummonCountLimit and Duel.IsPlayerAffectedByEffect(tp,92345028)
		and aux.ExtraDeckSummonCountLimit[tp]
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then loc=loc+LOCATION_GRAVE end
	if Duel.GetLocationCountFromEx(tp,tp,nil,TYPE_XYZ)>0 and (ect==nil or ect>1) then loc=loc+LOCATION_EXTRA end
	if chk==0 then return Duel.IsPlayerCanSpecialSummonCount(tp,2)
		and loc~=0
		and aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_XMATERIAL)
		and Duel.IsExistingMatchingCard(c57734012.filter1,tp,loc,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_EXTRA)
end
function c57734012.activate(e,tp,eg,ep,ev,re,r,rp)
	local loc=0
	local ect=aux.ExtraDeckSummonCountLimit and Duel.IsPlayerAffectedByEffect(tp,92345028)
		and aux.ExtraDeckSummonCountLimit[tp]
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then loc=loc+LOCATION_GRAVE end
	if Duel.GetLocationCountFromEx(tp,tp,nil,TYPE_XYZ)>0 and (ect==nil or ect>1) then loc=loc+LOCATION_EXTRA end
	if loc==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c57734012.filter1),tp,loc,0,1,1,nil,e,tp)
	local tc1=g1:GetFirst()
	if tc1 and Duel.SpecialSummon(tc1,0,tp,tp,false,false,POS_FACEUP)~=0 then
		if not aux.MustMaterialCheck(tc1,tp,EFFECT_MUST_BE_XMATERIAL) then return end
		local no=aux.GetXyzNumber(tc1)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(tp,c57734012.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc1,no)
		local tc2=g2:GetFirst()
		if tc2 then
			Duel.BreakEffect()
			tc2:SetMaterial(g1)
			Duel.Overlay(tc2,g1)
			Duel.SpecialSummon(tc2,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
			tc2:CompleteProcedure()
		end
	end
end
