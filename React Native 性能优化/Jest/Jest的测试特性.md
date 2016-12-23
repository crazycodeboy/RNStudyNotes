#Jest-Javascript单元测试工具
Jest是一个JavaScript测试框架，由Facebook用来测试所有JavaScript代码，包括React应用程序。

不同级别的自动化测试：单元、集成、组件和功能. 单元测试可以看作是和在组件级别测试JavaScript对象和方法一样的最基本的。默认情况下，React Native提供在Android和iOS都可以使用的Jest来进行单元测试。现在，测试的覆盖率并不完美，但是根据Facebook的说法，未来将会有更强大测试能力的工具被引入到React Native，同时用户也可以构建他们自己的测试工具。

## Jest的测试特性
适应性：Jest是模块化、可扩展和可配置的。

快速和沙盒:Jest虚拟化JavaScript环境,能模拟浏览器,并在工作进程之间并行运行测试。

快照测试:Jest能够对React 树进行快照或别的序列化数值快速编写测试,提供快速更新的用户体验。

快速交互模式: 错误信息会有帮助的颜色编码标记,堆栈跟踪快速指向问题的根源。

##使用
###配置Jest
可以使用npm运行 **npm install --save-dev jest**  也可以与使用所有的Js包一样:先配置package.json,再执行npm install。

###编写测试脚本
1.让我们写一个假设的测试是sum.js文件,函数为:

	module.exports = (a, b) => a + b;
	
2.创建一个目录____tests____/和文件xxx-test.js,或直接创建名称xxx.test.js或xxx.spec.js并把它放在你的项目的任何地方(**其实在jest中我们对脚步的定义是有约束的,采用这几钟创建方式,使jest在源码文件中可以找到测试脚步并执行**)

	test('adds 1 + 2 to equal 3', () => {
	  const sum = require('../sum');
	  expect(sum(1, 2)).toBe(3);
	});
	
3.执行脚本  (执行脚本有两种方式)

1)可以添加到package.json

	"scripts": {
 	  "test": "jest"
	 }
2)直接执行命令

需要安装全局jest命令: npm install -g jest,进入项目,执行命令:jest

4.运行
运行**npm test**会打印此消息：**PASS ____tests____/sum-test.js** 到此你就成功使用Jest写了你的第一个测试！

##断言
###API
    .expect(value)
    .lastCalledWith(arg1, arg2, ...) is an alias for .toHaveBeenLastCalledWith(arg1, arg2, ...)
    .not
    .toBe(value)
    .toBeCalled() is an alias for .toHaveBeenCalled()
    .toBeCalledWith(arg1, arg2, ...) is an alias for .toHaveBeenCalledWith(arg1, arg2, ...)
    .toHaveBeenCalled()
    .toHaveBeenCalledTimes(number)
    .toHaveBeenCalledWith(arg1, arg2, ...)
    .toHaveBeenLastCalledWith(arg1, arg2, ...)
    .toBeCloseTo(number, numDigits)
    .toBeDefined()
    .toBeFalsy()
    .toBeGreaterThan(number)
    .toBeGreaterThanOrEqual(number)
    .toBeLessThan(number)
    .toBeLessThanOrEqual(number)
    .toBeInstanceOf(Class)
    .toBeNull()
    .toBeTruthy()
    .toBeUndefined()
    .toContain(item)
    .toContainEqual(item)
    .toEqual(value)
    .toHaveLength(number)
    .toMatch(regexp)
    .toMatchObject(object)
    .toMatchSnapshot()
    .toThrow()
    .toThrowError(error)
    .toThrowErrorMatchingSnapshot()

##实例

####.toBeFalsy--------------------------------

使用toBeFalsy当你不在乎一个值是什么,你只是想确保在布尔上下文值是错误的时候使用它
可能一开始的代码是这样,你可能不关心getErrors回报,特别是,它可能会返回false,null,或0,代码仍然工作

在JavaScript中,有六个falsy值:false, 0, '', null, undefined, and NaN。其他的都是真。

	drinkSomeLaCroix();
	if (!getErrors()) {
	  drinkMoreLaCroix();
	}
	describe('drinking some La Croix', () => {
	  it('does not lead to errors', () => {
	     var getErrors = require('../js/sum');
	    expect(getErrors()).toBeFalsy();
	  });
	});

####.toBeGreaterThan---------------------------
比较浮点数,您可以使用toBeGreaterThan。例如,如果您想要测试,ouncesPerCan()返回的值超过10

	describe('ounces per can', () => {
	  it('is more than 10', () => {
	     var ouncesPerCan = require('../js/sum');
	    expect(ouncesPerCan()).toBeGreaterThan(10);
	  });
	});

####.toBeGreaterThanOrEqual--------------------
ouncesPerCan()返回的值至少12

	describe('ounces per can', () => {
	  it('is at least 12', () => {
	     var ouncesPerCan = require('../js/sum');
	    expect(ouncesPerCan()).toBeGreaterThanOrEqual(12);
	  });
	});

####.toBeLessThan------------------------------
ouncesPerCan()返回的值小于20

	describe('ounces per can', () => {
	  it('is less than 20', () => {
	     var ouncesPerCan = require('../js/sum');
	    expect(ouncesPerCan()).toBeLessThan(20);
	  });
	});

####.toBeLessThanOrEqual-----------------------
ouncesPerCan()返回的值最多12

	describe('ounces per can', () => {
	  it('is at most 12', () => {
	     var ouncesPerCan = require('../js/sum');
	    expect(ouncesPerCan()).toBeLessThanOrEqual(12);
	  });
	});

####.toBeInstanceOf----------------------------
使用.toBeInstanceOf(类)来检查一个对象是一个类的实例

	class A {}
	expect(new A()).toBeInstanceOf(A);
	expect(() => {}).toBeInstanceOf(Function);
	expect(new A()).toBeInstanceOf(Function); // throws

####.toBeNull-----------------------------------
.toBeNull 和 .toBe(null)是一样的,使用.toBeNull有点更好的错误消息。当你想检查null时所以使用.toBeNull()

	function bloop() {
	  return null;
	}
	describe('bloop', () => {
	  it('returns null', () => {
	    expect(bloop()).toBeNull();
	  });
	})

####.toBeTruthy----------------------------------
你可能不关心thirstInfo回报,特别是,它可能会返回true或一个复杂的对象,和代码仍然工作
可能一开始的代码是这样

	drinkSomeLaCroix();
	if (thirstInfo()) {
	  drinkMoreLaCroix();
	}
	describe('drinking some La Croix', () => {
	  it('leads to having thirst info', () => {
	 var thirstInfo = require('../js/sum');
	    expect(thirstInfo()).toBeTruthy();
	  });
	});

####.toContain----------------------------------
使用 .toContain当你想检查一个项目列表。测试列表中的项目,它使用===,检查是否对等

	describe('the list of all flavors', () => {
	  it('contains haha', () => {
	     var getAllFlavors = require('../js/sum');
	    expect(getAllFlavors()).toContain('haha');
	  });
	});

####.toEqual(value)-----------------------------
使用.toEqual当您想要检查两个对象具有相同的值。递归检查所有的字段是否相等,而不是检查对象的属性。例如,toEqual和toBr这个测试组件的反应是不同的

	const can1 = {
	  flavor: 'grapefruit',
	  ounces: 12,
	};
	const can2 = {
	  flavor: 'grapefruit',
	  ounces: 12,
	};
	
	describe('the La Croix cans on my desk', () => {
	  it('have all the same properties', () => {
	    expect(can1).toEqual(can2);
	  });
	  it('are not the exact same can', () => {
	    expect(can1).not.toBe(can2);
	  });
	});

####.toHaveLength(number)-------------------------
长度属性,设置一定的数值,这是特别有用的检查数组或字符串的大小。 

	expect([1, 2, 3]).toHaveLength(3);
	expect('abc').toHaveLength(3);
	expect('').not.toHaveLength(5);

####.toHaveLength(number)-------------------------

	expect([1, 2, 3]).toHaveLength(3);
	expect('abc').toHaveLength(3);
	expect('').not.toHaveLength(5);

####.toMatch(regexp)-----------------------------

	describe('an essay on the best flavor', () => {
	  it('mentions grapefruit', () => {
	    expect(essayOnTheBestFlavor()).toMatch(/grapefruit/);
	    expect(essayOnTheBestFlavor()).toMatch(new RegExp('grapefruit'));
	  })
	})
	
	describe('grapefruits are healthy', () => {
	  it('grapefruits are a fruit', () => {
	    expect('grapefruits').toMatch('fruit');
	  })
	})
	
####.toMatchObject(object)------------------------

	const houseForSale = {
	    bath: true,
	    kitchen: {
	        amenities: ['oven', 'stove', 'washer'],
	        area: 20,
	        wallColor: 'white'
	    },
	  bedrooms: 4
	};
	const desiredHouse = {
	    bath: true,
	    kitchen: {
	        amenities: ['oven', 'stove', 'washer'],
	        wallColor: 'white'
	    }
	};
	
	describe('looking for a new house', () => {
	    it('the house has my desired features', () => {
	        expect(houseForSale).toMatchObject(desiredHouse);
	    });
	});


###等等等-------------------------------
###附:[官网API Reference](http://facebook.github.io/jest/docs/api.html)
