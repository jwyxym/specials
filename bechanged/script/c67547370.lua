--眠れる巨人ズシン
function c67547370.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1)
	e2:SetCondition(c67547370.spcon1)
	e2:SetTarget(c67547370.sptg1)
	e2:SetOperation(c67547370.spop1)
	c:RegisterEffect(e2)
	--counter
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(67547370,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCategory(CATEGORY_COUNTER)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_HAND)
	e3:SetCountLimit(1)
	e3:SetCost(c67547370.countcost)
	e3:SetTarget(c67547370.counttg)
	e3:SetOperation(c67547370.countop)
	c:RegisterEffect(e3)
	--immune
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(c67547370.efilter)
	c:RegisterEffect(e4)
	--atk up
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(67547370,1))
	e5:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e5:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e5:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e5:SetCondition(c67547370.atkcon)
	e5:SetOperation(c67547370.atkop)
	c:RegisterEffect(e5)
	if not c67547370.global_check then
		c67547370.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetOperation(c67547370.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_SPSUMMON_SUCCESS)
		Duel.RegisterEffect(ge2,0)
	end
end
function c67547370.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		Duel.RegisterFlagEffect(tc:GetSummonPlayer(),67547370,RESET_PHASE+PHASE_END,0,1)
		tc=eg:GetNext()
	end
end
function c67547370.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2) and Duel.GetFlagEffect(1-tp,67547370)>=10
end
function c67547370.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,true) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c67547370.spop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,true,true,POS_FACEUP)
	c:CompleteProcedure()
end
function c67547370.cfilter(c,tp)
	return c:IsFaceup() and c:GetCounter(0x1039)==10
		and Duel.GetMZoneCount(tp,c)>0
end
function c67547370.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.CheckReleaseGroupEx(tp,c67547370.cfilter,1,REASON_SPSUMMON,false,nil,tp)
end
function c67547370.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetReleaseGroup(tp,false,REASON_SPSUMMON):Filter(c67547370.cfilter,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c67547370.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Release(g,REASON_SPSUMMON)
end
function c67547370.countcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PUBLIC)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c67547370.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL) and c:IsLevel(1) and c:IsCanAddCounter(0x1039,1)
end
function c67547370.counttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c67547370.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c67547370.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c67547370.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c67547370.countop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		tc:AddCounter(0x1039,1)
	end
end
function c67547370.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c67547370.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattleTarget()
end
function c67547370.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	local val=bc:GetAttack()+1000
	if c:IsRelateToBattle() and c:IsFaceup() and bc:IsRelateToBattle() and bc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(val)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		c:RegisterEffect(e2)
	end
end
