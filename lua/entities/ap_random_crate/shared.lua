ENT.Type 		= "anim"
ENT.Base 		= "base_anim"
ENT.PrintName		= "AP Random Item crate"
ENT.Category		= "APSC"
ENT.Author		= "NightShadowR/Mr.Fox"
ENT.Spawnable		= true
ENT.AdminOnly 		= true
ENT.DoNotDuplicate 	= true

if SERVER then

	AddCSLuaFile("shared.lua")

	function ENT:SpawnFunction(ply, tr)

		if (!tr.Hit) then return end
		
		local SpawnPos = tr.HitPos + tr.HitNormal * 16
		local ent = ents.Create("ap_random_crate")
		
		ent:SetPos(SpawnPos)
		ent:Spawn()
		ent:Activate()
		ent.Planted = false
		
		return ent

	end

	/*---------------------------------------------------------
	   Name: Initialize
	---------------------------------------------------------*/

	function ENT:Initialize()

		self.CanTool = false

		local model = ("models/Items/item_item_crate.mdl")
		
		self.Entity:SetModel(model)
		self.Entity:PhysicsInit(SOLID_VPHYSICS)
		self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
		self.Entity:SetSolid(SOLID_VPHYSICS)
		self.Entity:DrawShadow(false)
		self.Entity:SetCollisionGroup(COLLISION_GROUP_NONE)
		
		local phys = self.Entity:GetPhysicsObject()
		
		if (phys:IsValid()) then

			phys:Wake()
			phys:SetMass(40)

		end

		self.Entity:SetUseType(SIMPLE_USE)
	end


	/*---------------------------------------------------------
	   Name: PhysicsCollide
	---------------------------------------------------------*/

	function ENT:PhysicsCollide(data, physobj)
					
		if (data.Speed > 80 and data.DeltaTime > 0.2) then

			self.Entity:EmitSound(Sound("Wood.ImpactHard"))

		end
	end

	/*---------------------------------------------------------
	   Name: Use
	---------------------------------------------------------*/

	function ENT:Use(activator, caller)
		
		if (activator:IsPlayer()) and not self.Planted then
		
			local weapons = {

				"weapon_physgun",
				"gmod_tool"

			}

			local r = math.random( 1, 6 );
			local new_wep = weapons[r];

			activator:Give(new_wep);
			self.Entity:Remove()

		end

	end

else

	/*---------------------------------------------------------
	   Name: Initialize
	---------------------------------------------------------*/

	function ENT:Initialize()
		
	end

	/*---------------------------------------------------------
	   Name: DrawPre
	---------------------------------------------------------*/

	function ENT:Draw()
		
		self.Entity:DrawModel()
		
	end

end