--クリフォート・シェル
function c90885155.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c90885155.splimit)
	c:RegisterEffect(e2)
	--atk down
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetValue(-300)
	c:RegisterEffect(e3)
	--summon with no tribute
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(90885155,0))
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_SUMMON_PROC)
	e4:SetCondition(c90885155.ntcon)
	c:RegisterEffect(e4)
	--change level
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_SUMMON_COST)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetOperation(c90885155.lvop)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_SPSUMMON_COST)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetOperation(c90885155.lvop2)
	c:RegisterEffect(e6)
	--immune
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_IMMUNE_EFFECT)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCondition(c90885155.immcon)
	e7:SetValue(aux.qlifilter)
	c:RegisterEffect(e7)
	--effect
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_SUMMON_SUCCESS)
	e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e8:SetCondition(c90885155.effcon)
	e8:SetOperation(c90885155.effop)
	c:RegisterEffect(e8)
	--tribute check
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetCode(EFFECT_MATERIAL_CHECK)
	e9:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e9:SetValue(c90885155.valcheck)
	e9:SetLabelObject(e8)
	c:RegisterEffect(e9)
	--to pzone
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_IGNITION)
	e10:SetRange(LOCATION_HAND)
	e10:SetCondition(c90885155.pzcon)
	e10:SetTarget(c90885155.pztg)
	e10:SetOperation(c90885155.pzop)
	c:RegisterEffect(e10)
end
function c90885155.splimit(e,c)
	return not c:IsSetCard(0xaa)
end
function c90885155.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c90885155.lvcon(e)
	return e:GetHandler():GetMaterialCount()==0
end
function c90885155.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c90885155.lvcon)
	e1:SetValue(4)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_BASE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c90885155.lvcon)
	e2:SetValue(1800)
	e2:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e2)
end
function c90885155.lvop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(4)
	e1:SetReset(RESET_EVENT+0x7f0000)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_BASE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(1800)
	e2:SetReset(RESET_EVENT+0x7f0000)
	c:RegisterEffect(e2)
end
function c90885155.immcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_NORMAL)
end
function c90885155.effcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE) and e:GetLabel()==1
end
function c90885155.effop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e2)
end
function c90885155.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(Card.IsSetCard,1,nil,0xaa) then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end
function c90885155.pzfilter(c)
	return c:IsSetCard(0xaa)
end
function c90885155.pzcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c90885155.pzfilter,tp,LOCATION_PZONE,0,2,nil)
end
function c90885155.pztg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(1-tp,LOCATION_PZONE,0) or Duel.CheckLocation(1-tp,LOCATION_PZONE,1) end
end
function c90885155.pzop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not (Duel.CheckLocation(1-tp,LOCATION_PZONE,0) or Duel.CheckLocation(1-tp,LOCATION_PZONE,1)) then return end
	Duel.MoveToField(c,tp,1-tp,LOCATION_PZONE,POS_FACEUP,true)
end
