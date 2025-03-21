--巨神封じの矢
---@param c Card
function c67037924.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(67037924,0))
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP+TIMINGS_CHECK_MONSTER)
	e1:SetCountLimit(1,67037924)
	e1:SetCondition(aux.dscon)
	e1:SetTarget(c67037924.target)
	e1:SetOperation(c67037924.activate)
	c:RegisterEffect(e1)
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(67037924,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,67037925)
	e2:SetCondition(c67037924.setcon)
	e2:SetTarget(c67037924.settg)
	e2:SetOperation(c67037924.setop)
	c:RegisterEffect(e2)
	--act in hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(67037924,2))
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e3:SetCondition(c67037924.handcon)
	c:RegisterEffect(e3)
end
function c67037924.filter(c)
	return c:IsFaceup() and c:IsSummonLocation(LOCATION_EXTRA) and c:GetAttack()>0
end
function c67037924.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c67037924.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c67037924.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c67037924.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c67037924.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:GetAttack()>0 then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		tc:RegisterEffect(e2)
		Duel.AdjustInstantly(tc)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_SET_ATTACK_FINAL)
		e3:SetValue(0)
		tc:RegisterEffect(e3)
	end
end
function c67037924.cfilter(c,tp)
	return c:IsSummonLocation(LOCATION_EXTRA) and c:IsSummonPlayer(1-tp)
end
function c67037924.setcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c67037924.cfilter,1,nil,tp) and aux.exccon(e)
end
function c67037924.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c67037924.setop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,0x40)
		Duel.ConfirmCards(1-tp,c)
	end
end
function c67037924.handcon(e)
	return not Duel.IsExistingMatchingCard(c67037924.exfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c67037924.exfilter(c)
	return c:IsSummonLocation(LOCATION_EXTRA)
end