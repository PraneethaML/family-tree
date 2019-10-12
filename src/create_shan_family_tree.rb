require 'tree'   
class CreateShanFamilyTree
	
	def create_basic_tree
		anga = Tree::TreeNode.new('anga', {gender: 'female', relation: 'root'})
		shan = anga << Tree::TreeNode.new('shan', {gender: 'male', relation: 'spouse'}) 


		chit = anga << Tree::TreeNode.new('chit', {gender: 'male', relation: 'child'} )
		amba = chit << Tree::TreeNode.new('amba', {gender: 'female', relation: 'spouse'} )
		
		dritha = amba << Tree::TreeNode.new('dritha', {gender: 'female', relation: 'child'} )
		jaya = dritha << Tree::TreeNode.new('jaya', {gender: 'male', relation: 'spouse'} )
		yodhan = dritha << Tree::TreeNode.new('yodhan', {gender: 'male', relation: 'child'} )
		
		tritha = amba << Tree::TreeNode.new('tritha', {gender: 'female', relation: 'child'} )
		vritha = amba << Tree::TreeNode.new('vritha', {gender: 'female', relation: 'child'} )


		ish = anga << Tree::TreeNode.new('Ish', {gender: 'male', relation: 'child'})

		vich = anga << Tree::TreeNode.new('vich', {gender: 'male', relation: 'child'})
		lika = vich << Tree::TreeNode.new('lika', {gender: 'female', relation: 'spouse'})
		vila = lika << Tree::TreeNode.new('vika', {gender: 'female', relation: 'child'})
		chika = lika << Tree::TreeNode.new('chika', {gender: 'female', relation: 'child'})


		aras = anga << Tree::TreeNode.new('aras', {gender: 'male', relation: 'child'})
		chitra = aras << Tree::TreeNode.new('chitra', {gender: 'female', relation: 'spouse'})
		
		jnki = chitra << Tree::TreeNode.new('jnki', {gender: 'female', relation: 'child'})
		arit = jnki << Tree::TreeNode.new('arit', {gender: 'male', relation: 'spouse'})
		laki = jnki << Tree::TreeNode.new('laki', {gender: 'male', relation: 'child'})
		lavanya = jnki << Tree::TreeNode.new('lavanya', {gender: 'female', relation: 'child'})

		ahit = chitra << Tree::TreeNode.new('ahit', {gender: 'female', relation: 'child'})


		satya = anga << Tree::TreeNode.new('satya', {gender: 'female', relation: 'child'})
		vyan = satya << Tree::TreeNode.new('vyan', {gender: 'male', relation: 'spouse'})
		
		asva = satya << Tree::TreeNode.new('asva', {gender: 'male', relation: 'child'})
		satvy = asva << Tree::TreeNode.new('satvy', {gender: 'female', relation: 'spouse'})
		vasa = satvy << Tree::TreeNode.new('vasa', {gender: 'male', relation: 'child'})

		vyas = satya << Tree::TreeNode.new('vyas', {gender: 'male', relation: 'child'})
		krpi = vyas << Tree::TreeNode.new('krpi', {gender: 'female', relation: 'spouse'})
		kriya = krpi << Tree::TreeNode.new('kriya',{gender: 'male', relation: 'child'})
		krithi = krpi << Tree::TreeNode.new('krithi',{gender: 'female', relation: 'child'})	

		atya = satya << Tree::TreeNode.new('atya', {gender: 'female', relation: 'child'})

		return anga
	end
end