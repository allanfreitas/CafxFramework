package com.riacycle.core.strategy
{
	import mx.core.UIComponent;
	import com.riacycle.core.reflection.Field;

	public class UIContext
	{
		
		private var strategy:UIStrategy;
		
		public function UIContext(strategy:UIStrategy)
		{
			this.strategy = strategy;
		}
	
		public function executeStrategy(obj:Object, dataProviders:Array, field:Field):UIComponent{
			return this.strategy.executeStragegy(obj,dataProviders,field);
		}
		
	}
}