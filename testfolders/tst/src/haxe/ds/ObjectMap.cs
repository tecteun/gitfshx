
#pragma warning disable 109, 114, 219, 429, 168, 162
namespace haxe.ds {
	public class ObjectMap<K, V> : global::haxe.lang.HxObject, global::haxe.ds.ObjectMap, global::haxe.IMap<K, V> {
		
		public ObjectMap(global::haxe.lang.EmptyObject empty) {
		}
		
		
		public ObjectMap() {
			global::haxe.ds.ObjectMap<object, object>.__hx_ctor_haxe_ds_ObjectMap<K, V>(this);
		}
		
		
		public static void __hx_ctor_haxe_ds_ObjectMap<K_c, V_c>(global::haxe.ds.ObjectMap<K_c, V_c> __temp_me22) {
		}
		
		
		public static object __hx_cast<K_c_c, V_c_c>(global::haxe.ds.ObjectMap me) {
			return ( (( me != null )) ? (me.haxe_ds_ObjectMap_cast<K_c_c, V_c_c>()) : (null) );
		}
		
		
		public static new object __hx_createEmpty() {
			return new global::haxe.ds.ObjectMap<object, object>(global::haxe.lang.EmptyObject.EMPTY);
		}
		
		
		public static new object __hx_create(global::Array arr) {
			return new global::haxe.ds.ObjectMap<object, object>();
		}
		
		
		public virtual object haxe_ds_ObjectMap_cast<K_c, V_c>() {
			unchecked {
				if (( global::haxe.lang.Runtime.eq(typeof(K), typeof(K_c)) && global::haxe.lang.Runtime.eq(typeof(V), typeof(V_c)) )) {
					return this;
				}
				
				global::haxe.ds.ObjectMap<K_c, V_c> new_me = new global::haxe.ds.ObjectMap<K_c, V_c>(global::haxe.lang.EmptyObject.EMPTY);
				global::Array<object> fields = global::Reflect.fields(this);
				int i = 0;
				while (( i < fields.length )) {
					string field = global::haxe.lang.Runtime.toString(fields[i++]);
					switch (field) {
						case "vals":
						{
							if (( this.vals != null )) {
								V_c[] __temp_new_arr16 = new V_c[this.vals.Length];
								int __temp_i17 = -1;
								while ((  ++ __temp_i17 < this.vals.Length )) {
									object __temp_obj18 = ((object) (this.vals[__temp_i17]) );
									if (( __temp_obj18 != null )) {
										__temp_new_arr16[__temp_i17] = global::haxe.lang.Runtime.genericCast<V_c>(__temp_obj18);
									}
									
								}
								
								new_me.vals = __temp_new_arr16;
							}
							else {
								new_me.vals = null;
							}
							
							break;
						}
						
						
						case "_keys":
						{
							if (( this._keys != null )) {
								K_c[] __temp_new_arr19 = new K_c[this._keys.Length];
								int __temp_i20 = -1;
								while ((  ++ __temp_i20 < this._keys.Length )) {
									object __temp_obj21 = ((object) (this._keys[__temp_i20]) );
									if (( __temp_obj21 != null )) {
										__temp_new_arr19[__temp_i20] = global::haxe.lang.Runtime.genericCast<K_c>(__temp_obj21);
									}
									
								}
								
								new_me._keys = __temp_new_arr19;
							}
							else {
								new_me._keys = null;
							}
							
							break;
						}
						
						
						default:
						{
							global::Reflect.setField(new_me, field, global::Reflect.field(this, field));
							break;
						}
						
					}
					
				}
				
				return new_me;
			}
		}
		
		
		public virtual object haxe_IMap_cast<K_c, V_c>() {
			return this.haxe_ds_ObjectMap_cast<K_c, V_c>();
		}
		
		
		public int[] hashes;
		
		public K[] _keys;
		
		public V[] vals;
		
		public int nBuckets;
		
		public K cachedKey;
		
		public int cachedIndex;
		
		public override double __hx_setField_f(string field, int hash, double @value, bool handleProperties) {
			unchecked {
				switch (hash) {
					case 922671056:
					{
						this.cachedIndex = ((int) (@value) );
						return @value;
					}
					
					
					case 1395555037:
					{
						this.cachedKey = global::haxe.lang.Runtime.genericCast<K>(((object) (@value) ));
						return ((double) (global::haxe.lang.Runtime.toDouble(((object) (@value) ))) );
					}
					
					
					case 1537812987:
					{
						this.nBuckets = ((int) (@value) );
						return @value;
					}
					
					
					default:
					{
						return base.__hx_setField_f(field, hash, @value, handleProperties);
					}
					
				}
				
			}
		}
		
		
		public override object __hx_setField(string field, int hash, object @value, bool handleProperties) {
			unchecked {
				switch (hash) {
					case 922671056:
					{
						this.cachedIndex = ((int) (global::haxe.lang.Runtime.toInt(@value)) );
						return @value;
					}
					
					
					case 1395555037:
					{
						this.cachedKey = global::haxe.lang.Runtime.genericCast<K>(@value);
						return @value;
					}
					
					
					case 1537812987:
					{
						this.nBuckets = ((int) (global::haxe.lang.Runtime.toInt(@value)) );
						return @value;
					}
					
					
					case 1313416818:
					{
						this.vals = ((V[]) (@value) );
						return @value;
					}
					
					
					case 2048392659:
					{
						this._keys = ((K[]) (@value) );
						return @value;
					}
					
					
					case 995006396:
					{
						this.hashes = ((int[]) (@value) );
						return @value;
					}
					
					
					default:
					{
						return base.__hx_setField(field, hash, @value, handleProperties);
					}
					
				}
				
			}
		}
		
		
		public override object __hx_getField(string field, int hash, bool throwErrors, bool isCheck, bool handleProperties) {
			unchecked {
				switch (hash) {
					case 922671056:
					{
						return this.cachedIndex;
					}
					
					
					case 1395555037:
					{
						return this.cachedKey;
					}
					
					
					case 1537812987:
					{
						return this.nBuckets;
					}
					
					
					case 1313416818:
					{
						return this.vals;
					}
					
					
					case 2048392659:
					{
						return this._keys;
					}
					
					
					case 995006396:
					{
						return this.hashes;
					}
					
					
					default:
					{
						return base.__hx_getField(field, hash, throwErrors, isCheck, handleProperties);
					}
					
				}
				
			}
		}
		
		
		public override double __hx_getField_f(string field, int hash, bool throwErrors, bool handleProperties) {
			unchecked {
				switch (hash) {
					case 922671056:
					{
						return ((double) (this.cachedIndex) );
					}
					
					
					case 1395555037:
					{
						return ((double) (global::haxe.lang.Runtime.toDouble(((object) (this.cachedKey) ))) );
					}
					
					
					case 1537812987:
					{
						return ((double) (this.nBuckets) );
					}
					
					
					default:
					{
						return base.__hx_getField_f(field, hash, throwErrors, handleProperties);
					}
					
				}
				
			}
		}
		
		
		public override void __hx_getFields(global::Array<object> baseArr) {
			baseArr.push("cachedIndex");
			baseArr.push("cachedKey");
			baseArr.push("nBuckets");
			baseArr.push("vals");
			baseArr.push("_keys");
			baseArr.push("hashes");
			{
				base.__hx_getFields(baseArr);
			}
			
		}
		
		
	}
}



#pragma warning disable 109, 114, 219, 429, 168, 162
namespace haxe.ds {
	[global::haxe.lang.GenericInterface(typeof(global::haxe.ds.ObjectMap<object, object>))]
	public interface ObjectMap : global::haxe.lang.IHxObject, global::haxe.lang.IGenericObject {
		
		object haxe_ds_ObjectMap_cast<K_c, V_c>();
		
		object haxe_IMap_cast<K_c, V_c>();
		
	}
}



#pragma warning disable 109, 114, 219, 429, 168, 162
namespace haxe.ds._ObjectMap {
	public sealed class ObjectMapKeyIterator<T, V> : global::haxe.lang.HxObject, global::haxe.ds._ObjectMap.ObjectMapKeyIterator {
		
		public ObjectMapKeyIterator(global::haxe.lang.EmptyObject empty) {
		}
		
		
		public ObjectMapKeyIterator(global::haxe.ds.ObjectMap<T, V> m) {
			global::haxe.ds._ObjectMap.ObjectMapKeyIterator<object, object>.__hx_ctor_haxe_ds__ObjectMap_ObjectMapKeyIterator<T, V>(this, m);
		}
		
		
		public static void __hx_ctor_haxe_ds__ObjectMap_ObjectMapKeyIterator<T_c, V_c>(global::haxe.ds._ObjectMap.ObjectMapKeyIterator<T_c, V_c> __temp_me23, global::haxe.ds.ObjectMap<T_c, V_c> m) {
			__temp_me23.i = 0;
			__temp_me23.m = m;
			__temp_me23.len = m.nBuckets;
		}
		
		
		public static object __hx_cast<T_c_c, V_c_c>(global::haxe.ds._ObjectMap.ObjectMapKeyIterator me) {
			return ( (( me != null )) ? (me.haxe_ds__ObjectMap_ObjectMapKeyIterator_cast<T_c_c, V_c_c>()) : (null) );
		}
		
		
		public static new object __hx_createEmpty() {
			return new global::haxe.ds._ObjectMap.ObjectMapKeyIterator<object, object>(((global::haxe.lang.EmptyObject) (global::haxe.lang.EmptyObject.EMPTY) ));
		}
		
		
		public static new object __hx_create(global::Array arr) {
			return new global::haxe.ds._ObjectMap.ObjectMapKeyIterator<object, object>(((global::haxe.ds.ObjectMap<object, object>) (global::haxe.ds.ObjectMap<object, object>.__hx_cast<object, object>(((global::haxe.ds.ObjectMap) (arr[0]) ))) ));
		}
		
		
		public object haxe_ds__ObjectMap_ObjectMapKeyIterator_cast<T_c, V_c>() {
			if (( global::haxe.lang.Runtime.eq(typeof(T), typeof(T_c)) && global::haxe.lang.Runtime.eq(typeof(V), typeof(V_c)) )) {
				return this;
			}
			
			global::haxe.ds._ObjectMap.ObjectMapKeyIterator<T_c, V_c> new_me = new global::haxe.ds._ObjectMap.ObjectMapKeyIterator<T_c, V_c>(((global::haxe.lang.EmptyObject) (global::haxe.lang.EmptyObject.EMPTY) ));
			global::Array<object> fields = global::Reflect.fields(this);
			int i = 0;
			while (( i < fields.length )) {
				string field = global::haxe.lang.Runtime.toString(fields[i++]);
				global::Reflect.setField(new_me, field, global::Reflect.field(this, field));
			}
			
			return new_me;
		}
		
		
		public global::haxe.ds.ObjectMap<T, V> m;
		
		public int i;
		
		public int len;
		
		public bool hasNext() {
			unchecked {
				{
					int _g1 = this.i;
					int _g = this.len;
					while (( _g1 < _g )) {
						int j = _g1++;
						if ( ! ((( (( this.m.hashes[j] & -2 )) == 0 ))) ) {
							this.i = j;
							return true;
						}
						
					}
					
				}
				
				return false;
			}
		}
		
		
		public T next() {
			unchecked {
				T ret = this.m._keys[this.i];
				this.m.cachedIndex = this.i;
				this.m.cachedKey = ret;
				this.i = ( this.i + 1 );
				return ret;
			}
		}
		
		
		public override double __hx_setField_f(string field, int hash, double @value, bool handleProperties) {
			unchecked {
				switch (hash) {
					case 5393365:
					{
						this.len = ((int) (@value) );
						return @value;
					}
					
					
					case 105:
					{
						this.i = ((int) (@value) );
						return @value;
					}
					
					
					default:
					{
						return base.__hx_setField_f(field, hash, @value, handleProperties);
					}
					
				}
				
			}
		}
		
		
		public override object __hx_setField(string field, int hash, object @value, bool handleProperties) {
			unchecked {
				switch (hash) {
					case 5393365:
					{
						this.len = ((int) (global::haxe.lang.Runtime.toInt(@value)) );
						return @value;
					}
					
					
					case 105:
					{
						this.i = ((int) (global::haxe.lang.Runtime.toInt(@value)) );
						return @value;
					}
					
					
					case 109:
					{
						this.m = ((global::haxe.ds.ObjectMap<T, V>) (global::haxe.ds.ObjectMap<object, object>.__hx_cast<T, V>(((global::haxe.ds.ObjectMap) (@value) ))) );
						return @value;
					}
					
					
					default:
					{
						return base.__hx_setField(field, hash, @value, handleProperties);
					}
					
				}
				
			}
		}
		
		
		public override object __hx_getField(string field, int hash, bool throwErrors, bool isCheck, bool handleProperties) {
			unchecked {
				switch (hash) {
					case 1224901875:
					{
						return ((global::haxe.lang.Function) (new global::haxe.lang.Closure(this, "next", 1224901875)) );
					}
					
					
					case 407283053:
					{
						return ((global::haxe.lang.Function) (new global::haxe.lang.Closure(this, "hasNext", 407283053)) );
					}
					
					
					case 5393365:
					{
						return this.len;
					}
					
					
					case 105:
					{
						return this.i;
					}
					
					
					case 109:
					{
						return this.m;
					}
					
					
					default:
					{
						return base.__hx_getField(field, hash, throwErrors, isCheck, handleProperties);
					}
					
				}
				
			}
		}
		
		
		public override double __hx_getField_f(string field, int hash, bool throwErrors, bool handleProperties) {
			unchecked {
				switch (hash) {
					case 5393365:
					{
						return ((double) (this.len) );
					}
					
					
					case 105:
					{
						return ((double) (this.i) );
					}
					
					
					default:
					{
						return base.__hx_getField_f(field, hash, throwErrors, handleProperties);
					}
					
				}
				
			}
		}
		
		
		public override object __hx_invokeField(string field, int hash, global::Array dynargs) {
			unchecked {
				switch (hash) {
					case 1224901875:
					{
						return this.next();
					}
					
					
					case 407283053:
					{
						return this.hasNext();
					}
					
					
					default:
					{
						return base.__hx_invokeField(field, hash, dynargs);
					}
					
				}
				
			}
		}
		
		
		public override void __hx_getFields(global::Array<object> baseArr) {
			baseArr.push("len");
			baseArr.push("i");
			baseArr.push("m");
			{
				base.__hx_getFields(baseArr);
			}
			
		}
		
		
	}
}



#pragma warning disable 109, 114, 219, 429, 168, 162
namespace haxe.ds._ObjectMap {
	[global::haxe.lang.GenericInterface(typeof(global::haxe.ds._ObjectMap.ObjectMapKeyIterator<object, object>))]
	public interface ObjectMapKeyIterator : global::haxe.lang.IHxObject, global::haxe.lang.IGenericObject {
		
		object haxe_ds__ObjectMap_ObjectMapKeyIterator_cast<T_c, V_c>();
		
		bool hasNext();
		
	}
}



#pragma warning disable 109, 114, 219, 429, 168, 162
namespace haxe.ds._ObjectMap {
	public sealed class ObjectMapValueIterator<K, T> : global::haxe.lang.HxObject, global::haxe.ds._ObjectMap.ObjectMapValueIterator {
		
		public ObjectMapValueIterator(global::haxe.lang.EmptyObject empty) {
		}
		
		
		public ObjectMapValueIterator(global::haxe.ds.ObjectMap<K, T> m) {
			global::haxe.ds._ObjectMap.ObjectMapValueIterator<object, object>.__hx_ctor_haxe_ds__ObjectMap_ObjectMapValueIterator<K, T>(this, m);
		}
		
		
		public static void __hx_ctor_haxe_ds__ObjectMap_ObjectMapValueIterator<K_c, T_c>(global::haxe.ds._ObjectMap.ObjectMapValueIterator<K_c, T_c> __temp_me24, global::haxe.ds.ObjectMap<K_c, T_c> m) {
			__temp_me24.i = 0;
			__temp_me24.m = m;
			__temp_me24.len = m.nBuckets;
		}
		
		
		public static object __hx_cast<K_c_c, T_c_c>(global::haxe.ds._ObjectMap.ObjectMapValueIterator me) {
			return ( (( me != null )) ? (me.haxe_ds__ObjectMap_ObjectMapValueIterator_cast<K_c_c, T_c_c>()) : (null) );
		}
		
		
		public static new object __hx_createEmpty() {
			return new global::haxe.ds._ObjectMap.ObjectMapValueIterator<object, object>(((global::haxe.lang.EmptyObject) (global::haxe.lang.EmptyObject.EMPTY) ));
		}
		
		
		public static new object __hx_create(global::Array arr) {
			return new global::haxe.ds._ObjectMap.ObjectMapValueIterator<object, object>(((global::haxe.ds.ObjectMap<object, object>) (global::haxe.ds.ObjectMap<object, object>.__hx_cast<object, object>(((global::haxe.ds.ObjectMap) (arr[0]) ))) ));
		}
		
		
		public object haxe_ds__ObjectMap_ObjectMapValueIterator_cast<K_c, T_c>() {
			if (( global::haxe.lang.Runtime.eq(typeof(K), typeof(K_c)) && global::haxe.lang.Runtime.eq(typeof(T), typeof(T_c)) )) {
				return this;
			}
			
			global::haxe.ds._ObjectMap.ObjectMapValueIterator<K_c, T_c> new_me = new global::haxe.ds._ObjectMap.ObjectMapValueIterator<K_c, T_c>(((global::haxe.lang.EmptyObject) (global::haxe.lang.EmptyObject.EMPTY) ));
			global::Array<object> fields = global::Reflect.fields(this);
			int i = 0;
			while (( i < fields.length )) {
				string field = global::haxe.lang.Runtime.toString(fields[i++]);
				global::Reflect.setField(new_me, field, global::Reflect.field(this, field));
			}
			
			return new_me;
		}
		
		
		public global::haxe.ds.ObjectMap<K, T> m;
		
		public int i;
		
		public int len;
		
		public bool hasNext() {
			unchecked {
				{
					int _g1 = this.i;
					int _g = this.len;
					while (( _g1 < _g )) {
						int j = _g1++;
						if ( ! ((( (( this.m.hashes[j] & -2 )) == 0 ))) ) {
							this.i = j;
							return true;
						}
						
					}
					
				}
				
				return false;
			}
		}
		
		
		public T next() {
			unchecked {
				T ret = this.m.vals[this.i];
				this.i = ( this.i + 1 );
				return ret;
			}
		}
		
		
		public override double __hx_setField_f(string field, int hash, double @value, bool handleProperties) {
			unchecked {
				switch (hash) {
					case 5393365:
					{
						this.len = ((int) (@value) );
						return @value;
					}
					
					
					case 105:
					{
						this.i = ((int) (@value) );
						return @value;
					}
					
					
					default:
					{
						return base.__hx_setField_f(field, hash, @value, handleProperties);
					}
					
				}
				
			}
		}
		
		
		public override object __hx_setField(string field, int hash, object @value, bool handleProperties) {
			unchecked {
				switch (hash) {
					case 5393365:
					{
						this.len = ((int) (global::haxe.lang.Runtime.toInt(@value)) );
						return @value;
					}
					
					
					case 105:
					{
						this.i = ((int) (global::haxe.lang.Runtime.toInt(@value)) );
						return @value;
					}
					
					
					case 109:
					{
						this.m = ((global::haxe.ds.ObjectMap<K, T>) (global::haxe.ds.ObjectMap<object, object>.__hx_cast<K, T>(((global::haxe.ds.ObjectMap) (@value) ))) );
						return @value;
					}
					
					
					default:
					{
						return base.__hx_setField(field, hash, @value, handleProperties);
					}
					
				}
				
			}
		}
		
		
		public override object __hx_getField(string field, int hash, bool throwErrors, bool isCheck, bool handleProperties) {
			unchecked {
				switch (hash) {
					case 1224901875:
					{
						return ((global::haxe.lang.Function) (new global::haxe.lang.Closure(this, "next", 1224901875)) );
					}
					
					
					case 407283053:
					{
						return ((global::haxe.lang.Function) (new global::haxe.lang.Closure(this, "hasNext", 407283053)) );
					}
					
					
					case 5393365:
					{
						return this.len;
					}
					
					
					case 105:
					{
						return this.i;
					}
					
					
					case 109:
					{
						return this.m;
					}
					
					
					default:
					{
						return base.__hx_getField(field, hash, throwErrors, isCheck, handleProperties);
					}
					
				}
				
			}
		}
		
		
		public override double __hx_getField_f(string field, int hash, bool throwErrors, bool handleProperties) {
			unchecked {
				switch (hash) {
					case 5393365:
					{
						return ((double) (this.len) );
					}
					
					
					case 105:
					{
						return ((double) (this.i) );
					}
					
					
					default:
					{
						return base.__hx_getField_f(field, hash, throwErrors, handleProperties);
					}
					
				}
				
			}
		}
		
		
		public override object __hx_invokeField(string field, int hash, global::Array dynargs) {
			unchecked {
				switch (hash) {
					case 1224901875:
					{
						return this.next();
					}
					
					
					case 407283053:
					{
						return this.hasNext();
					}
					
					
					default:
					{
						return base.__hx_invokeField(field, hash, dynargs);
					}
					
				}
				
			}
		}
		
		
		public override void __hx_getFields(global::Array<object> baseArr) {
			baseArr.push("len");
			baseArr.push("i");
			baseArr.push("m");
			{
				base.__hx_getFields(baseArr);
			}
			
		}
		
		
	}
}



#pragma warning disable 109, 114, 219, 429, 168, 162
namespace haxe.ds._ObjectMap {
	[global::haxe.lang.GenericInterface(typeof(global::haxe.ds._ObjectMap.ObjectMapValueIterator<object, object>))]
	public interface ObjectMapValueIterator : global::haxe.lang.IHxObject, global::haxe.lang.IGenericObject {
		
		object haxe_ds__ObjectMap_ObjectMapValueIterator_cast<K_c, T_c>();
		
		bool hasNext();
		
	}
}


