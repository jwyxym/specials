--アブソリュート・パワーフォース
function c51779204.initial_effect(c)
	aux.AddCodeList(c,70902743)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,51779204)
	e1:SetTarget(c51779204.thtg)
	e1:SetOperation(c51779204.thop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(51779204,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,51779205)
	e2:SetTarget(c51779204.target)
	e2:SetOperation(c51779204.activate)
	c:RegisterEffect(e2)
end
function c51779204.thfilter(c)
	return c:IsAttribute(ATTRIBUTE_FIRE+ATTRIBUTE_DARK) and c:IsRace(RACE_FIEND+RACE_DRAGON) and c:IsType(TYPE_TUNER) and c:IsAbleToHand()
end
function c51779204.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c51779204.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c51779204.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c51779204.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c51779204.filter(c)
	return c:IsFaceup() and c:IsCode(70902743)
end
function c51779204.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c51779204.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c51779204.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c51779204.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c51779204.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetCondition(c51779204.atkcon)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
		tc:RegisterEffect(e1)
		if tc:GetFlagEffect(51779204)==0 then
			tc:RegisterFlagEffect(51779204,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_FIELD)
			e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e2:SetCode(EFFECT_CANNOT_ACTIVATE)
			e2:SetRange(LOCATION_MZONE)
			e2:SetTargetRange(0,1)
			e2:SetCondition(c51779204.actcon)
			e2:SetValue(1)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
			tc:RegisterEffect(e2,true)
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_PIERCE)
			e3:SetCondition(c51779204.effcon)
			e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
			tc:RegisterEffect(e3)
			local e4=Effect.CreateEffect(c)
			e4:SetType(EFFECT_TYPE_SINGLE)
			e4:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
			e4:SetCondition(c51779204.damcon)
			e4:SetValue(aux.ChangeBattleDamage(1,DOUBLE_DAMAGE))
			e4:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
			tc:RegisterEffect(e4,true)
		end
	end
end
function c51779204.atkcon(e)
	if bit.band(Duel.GetCurrentPhase(),PHASE_DAMAGE+PHASE_DAMAGE_CAL)==0 then return false end
	local c=e:GetHandler()
	return (Duel.GetAttacker()==c or Duel.GetAttackTarget()==c) and c:GetBattleTarget()~=nil
		and e:GetOwnerPlayer()==e:GetHandlerPlayer()
end
function c51779204.actcon(e)
	local c=e:GetHandler()
	return (Duel.GetAttacker()==c or Duel.GetAttackTarget()==c) and c:GetBattleTarget()~=nil
		and e:GetOwnerPlayer()==e:GetHandlerPlayer()
end
function c51779204.effcon(e)
	return e:GetOwnerPlayer()==e:GetHandlerPlayer()
end
function c51779204.damcon(e)
	return e:GetHandler():GetBattleTarget()~=nil
end
