

# all posible trpc middlewares	#


## NO middlewares ##
useNoUserCrud   	// user's crud operation not allows
useNoUserRead
useNo
useNoEditorCrud
useNoEditorRead 
useNoEditorPut
useNo


##	must middleWares 	##
useMustAuthenticated // only authenticated can access
useMustAdmin // only admin can access
useMustEditor 
useMustProUser //  only pro users can access
useMustFreeUser // only free users can access


## 	##