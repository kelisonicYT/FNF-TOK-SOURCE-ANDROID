package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;

#if windows
import Discord.DiscordClient;
#end

#if cpp
import sys.thread.Thread;
#end

using StringTools;

class TitleState extends MusicBeatState
{
	static var initialized:Bool = false;

	var blackScreen:FlxSprite;
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var ngSpr:FlxSprite;
	var canselect:Bool;

	var curWacky:Array<String> = [];

	var wackyImage:FlxSprite;

                    


/*///////////////////&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
/////////////////////&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&/////////////////////
/////////////&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&%////////////
/////////%%%%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&%%%%////////
////////(&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&////////
////////(&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&////////
////////(&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&////////
////%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&////
////%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&////
////%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&////
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&#(((%&&&&&&&&((((&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&#(((%&&&&&&&&((((&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&#((((((((&&&&((((((((%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&((((((((((((((((((((((((((((((((((&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&((((((((((((((((((((((((((((((((((&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&((((,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,((((%&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&((((,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,((((%&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,#&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&*,,,,,,,,&&&&&&&&&&&&&&&&#,,,,,,,,,,,,&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&*,,,,,,,,&&&&&&&&&&&&&&&&#,,,,,,,,,,,,&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&(,,,,,,,,,,,,,,,,,,,,,,,,,,,,,&&&&&&&&&&&&&&&&&&&&&&&&&		@@@@@          @@@@@@@@@@@@@@@@@                   #@@@@ 
&&&&&&&&&&&&&&&&&&&&&&&&&(,,,,,,,,,,,,,,,,,,,,,,,,,,,,,&&&&&&&&&&&&&&&&&&&&&&&&&		@@@%%@@@@@@@@@@%%%%%%%%%%%%%%%%%@@@@@@@       ,@@@@&%%@@    
////%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&,,,,,,,,/&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&.@@%%%%%@@%%%%%%%%%%%%%%%%%&@@%%%%%%%@@@@@@@&%%%%%%%@@@@@@@       
////%&&&&((((&&&&((((&&&&&&&&&&&&&&&&&,,,,,,,,/&&&&&&&&&&&&((((%&&&&((((&&&&((((	@@@@@@@@@@@@&%%%%%%%%%%%%%%%%%%%%%%%%@@@@@%%%%%%%%%%%%%%%%%%%%%%@@     
////%&&&%////&&&&////&&&&&&&&&&&&&&&&&,,,,,,,,/&&&&&&&&&&&&////%&&&%////&&&&////	@@@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%@@@@@%%%%%%%%%%%%%%@@@   
/////////////////////&&&&&&&&&&&&&&&&&,,,,,,,,/&&&&&&&&&&&&&&&&#////////////////			@@@@@%%%%%%%%%%%%%%@@@@@@@@@@%%%%%%%%%%%%%%%@@%%%%%%%%%%%%@@@  
/////////////////////&&&&&&&&&&&&&&&&&,,,,,,,,/&&&&&&&&&&&&&&&&#////////////////			@@%%%%%%%%%%%%%%%@@          @@@@@%%%%%%%@@@@@%%%%%%%%%%@@  
/////////////////&&&&*,,,,,,,,&&&&&&&&&&&&&&&&&&&&&&&&&,,,,,,,,#&&&%////////////		@@@%%%%%%%%%%%%%%&@@              /@@@@@@@@@@@@%%%%%%%%%&@@@@     
/////////////####((((,,,,,,,,,((((&&&&&&&&&&&&&&&&&((((,,,,,,,,/((((####////////		@@%%%%%%%%%%%%%%%@@          		@@@@@%%%%%%%@@@@@%%%%%%%%%%@@  
/////////////&&&&,,,,,,,,,,,,,,,,,&&&&&&&&&&&&&&&&&,,,,,,,,,,,,,,,,*&&&&////////	@@@%%%%%%%%%%%%%%&@@             		 /@@@@@@@@@@@@%%%%%%%%%&@@@@  
/////////////&&&&.........,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,........,&&&&////////	@@@@@@@%%%%%%%&@@@@@@@     @@      	 /@@@@@@@%%%%%%%%%%%%%%%%%%%@@@@@   @@@@# 
/////////////&&&&.........,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,........,&&&&////////		@@@@@@@@@@@@@@@              			/@@%%%%%%%%%%%%%%%%%%%%%%%%%%%@@@@@**@@@@@@@	trace('god FUCKING dammit KRIS where the FUCK are we??');	
/////////////&&&&..................................................,&&&&////////		.@@**(%%@@@@@@@          			##&@@%%%%%%%%%%%%@@&%%%%&@@@@@@@@@###**##(**@@
/////////((((%%%%....,,,,..................................,,,,....,%%%%((((////			.@@**(%%@@@@@@@          ##&@@%%%%%%%%%%%%@@&%%%%&@@@@@@@@@###**##(**@@
////////(&&&&........((((*.................................((((*........&&&&////		@@&**************##########**#@@%%%%%%%%%%%%@@@@@@@@@@@@@@@*****##*****@@
////////(&&&&,,,,,,,,((((*.................................((((*,,,,,,,,&&&&////		@@&**%%(*********************#@@%%%%%%%%%%@@##(**##&@@,,@@@##*******(@@  
////////(&&&&,,,,,,,,((((*.................................((((*,,,,,,,,&&&&////		@@&**********************##@@@@@%%%%%%%%%%@@*******%@@@@@@@@@*****@@@@@  
////////(&&&&,,,,,,,,&&&&(,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,&&&&(,,,,,,,,&&&&////			.@@************###@@@@@@@@@@@@%%%%%%%%%%@@*******(##@@@@@@@**********@@
////////(&&&&,,,,,,,,&&&&(,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,&&&&(,,,,,,,,&&&&////				@@@@@@@@@@@@@@@@@#####@@@@@@@%%%%%%%%@@*******(##@@,,,@@@@@@@@@@@@@@
////////(&&&&,,,,,,,,&&&&(,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,&&&&(,,,,,,,,&&&&////			.@@**(@@@@@@@@@@@@@@@@@@@@@@@@@@%%%%%@@@#######@@@@@@@@@@@@            
((((((((#&&&&&&&&&&&&&&&&(,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,&&&&&&&&&&&&&&&&&((((		@@@@&**#####@@@@@@@@@@*******@@@@@@@%%%%%@@@##@@@@@     
((((((((#&&&&&&&&&&&&&&&&(,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,&&&&&&&&&&&&&&&&&((((	@@@************@@*,,@@*****##%@@@@@@@@@%%%%%@@@@@ 
((((((((#&&&&,,,,,,,,,,,,(&&&&,,,,,,,,,,,,,,,,,,,,,,,,,&&&&,,,,,,,,,,,,,&&&&((((	@@***************@@@@@@@********##@@@@@@@@@@%%@@@   
((((((((#&&&&,,,,,,,,,,,,(&&&&,,,,,,,,,,,,,,,,,,,,,,,,,&&&&,,,,,,,,,,,,,&&&&((((	@@************(@@,,&@@************@@%##@@@@@@@@@@   
////////(&&&&,,,,,,,,,,,,(&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&,,,,,,,,,,,,,&&&&////	#@@@@@@@*********(@@@@@@@*******@@@@@@@%##@@.   
(((((((((((((&&&&&&&&&&&&&&&&&&&&&&&&&((((&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&((((((((@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,,&@@@@@@@,,@@&,,@@@@@   
(((((((((((((&&&&&&&&&&&&&&&&&&&&&&&&&((((&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&((((((((	@@##%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,,,,*@@@@@@@@@@@@ 
(((((((((((((((((((((((((%&&&&&&&&&&&&((((&&&&&&&&&&&&&&&&&(((((((((((((((((((((	@@&#######@@@@@@@@@@#######@@%%%%%@@@@@@@&%%%%%%%%%@@@@@
(((((((((((((((((((((((((%&&&&&&&&&&&&((((&&&&&&&&&&&&&&&&&(((((((((((((((((((((		*@@@@@@@##########@@@@@@@%%%%%%%%%%%%%%%%%%%%%%%%%%%@@   
(((((((((((((((((((((((((%&&&&&&&&&&&&((((&&&&&&&&&&&&&&&&&(((((((((((((((((((((			#@@@@@@@@@@@@%%%%%%%%%%%%%%@@@@@%%%%%%%%%%%%%%%@@       
(((((((((((((((((((((((((%&&&&&&&&&&&&((((&&&&&&&&&&&&&&&&&(((((((((((((((((((((				@@%%%%%%%%%%%%%%%%%&@@@@%%%%%%%%%%%%%%%%%%%%@@ 
(((((((((((((((((((((((((%&&&&&&&&&&&&((((&&&&&&&&&&&&&&&&&(((((((((((((((((((((					@@%%%%%%%%%%%%%%%%%&@@@@%%%%%%%%%%%%%%%%%%%%@@ 
(((((((((((((((((((((((((%&&&&&&&&&&&&((((&&&&&&&&&&&&&&&&&(((((((((((((((((((((				#@@@@%%%%%%%%%%%%%%%%%&@@  @@@%%%%%%%%%%%%%%@@@ 
(((((((((((((((((((((((((%&&&&&&&&&&&&((((&&&&&&&&&&&&&&&&&(((((((((((((((((((((				#@@@@@@@@@%%%%%%%%%%@@,    @@@@@@@@@@@@@@@@@.    
(((((((((((((((((((((((((%&&&&&&&&&&&&((((&&&&&&&&&&&&&&&&&(((((((((((((((((((((			@@@@@@@@@@@@@@@@@@@@@@     @@@@@@@@@@@@@@@@@@@.
(((((((((((((((((((((((((%&&&&&&&&&&&&((((&&&&&&&&&&&&&&&&&(((((((((((((((((((((			@@@@@@@@@@@@@@@@@@@@@@       %@@@@@@@@@@@@@@@@@@@  
/////////((((((((((((((((%&&&&&&&&&&&&((((&&&&&&&&&&&&&&&&&(((((((((((((((((((((		...@@@@@@@@@@@@@@@@@@@@@@              #&&,,,,,&&&&&&&&&&&&&&&&&@@ 
/////////////((((&&&&&&&&&&&&&&&&&&&&&((((&&&&&&&&&&&&&&&&&&&&&&&&&&((((((((((((		@@@@@@@@@@@@@@@@@@@@%%%%%                        ,,,,,,,,,,,,,,,##    
/////////////((((&&&&&&&&&&&&&&&&&&&&&((((&&&&&&&&&&&&&&&&&&&&&&&&&&((((((((((((		.../////////*.....*/   																																				             
																																					               
																																				            																	       
																																		         
																																				  


	override public function create():Void
	{

		@:privateAccess
		{
			trace("Loaded " + openfl.Assets.getLibrary("default").assetsLoaded + " assets (DEFAULT)");
		}
		
		PlayerSettings.init();

		#if windows
		DiscordClient.initialize();

		Application.current.onExit.add (function (exitCode) {
			DiscordClient.shutdown();
		 });
		 
		#end

		curWacky = FlxG.random.getObject(getIntroTextShit());

		// DEBUG BULLSHIT

		super.create();

		// NGio.noLogin(APIStuff.API);

		#if ng
		var ng:NGio = new NGio(APIStuff.API, APIStuff.EncKey);
		trace('NEWGROUNDS LOL');
		#end

		FlxG.save.bind('funkin', 'ninjamuffin99');

		KadeEngineData.initSave();

		Highscore.load();

		if (FlxG.save.data.weekUnlocked != null)
		{
			// FIX LATER!!!
			// WEEK UNLOCK PROGRESSION!!
			// StoryMenuState.weekUnlocked = FlxG.save.data.weekUnlocked;

			if (StoryMenuState.weekUnlocked.length < 4)
				StoryMenuState.weekUnlocked.insert(0, true);

			// QUICK PATCH OOPS!
			if (!StoryMenuState.weekUnlocked[0])
				StoryMenuState.weekUnlocked[0] = true;
		}

		#if FREEPLAY
		FlxG.switchState(new FreeplayState());
		#elseif CHARTING
		FlxG.switchState(new ChartingState());
		#else
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			startIntro();
		});
		#end
	}

	var titlescroll:FlxSprite;
	var clonescroll:FlxSprite;
	var logoBl:FlxSprite;
	var gfDance:FlxSprite;
	var titleText:FlxSprite;

	var scrollset:Int = 1400;

	function startIntro()
	{
		if (!initialized)
		{
			var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
			diamond.persist = true;
			diamond.destroyOnNoUse = false;

			FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 1, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
				new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
			FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.7, new FlxPoint(0, 1),
				{asset: diamond, width: 32, height: 32}, new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));

			transIn = FlxTransitionableState.defaultTransIn;
			transOut = FlxTransitionableState.defaultTransOut;

			// HAD TO MODIFY SOME BACKEND SHIT
			// IF THIS PR IS HERE IF ITS ACCEPTED UR GOOD TO GO
			// https://github.com/HaxeFlixel/flixel-addons/pull/348

			// var music:FlxSound = new FlxSound();
			// music.loadStream(Paths.music('freakyMenu'));
			// FlxG.sound.list.add(music);
			// music.play();
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);

			FlxG.sound.music.fadeIn(4, 0, 0.7);
		}

		Conductor.changeBPM(103);
		persistentUpdate = true;

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		// bg.antialiasing = true;
		// bg.setGraphicSize(Std.int(bg.width * 0.6));
		// bg.updateHitbox();
		add(bg);

		
			logoBl = new FlxSprite(400, -100);
			logoBl.frames = Paths.getSparrowAtlas('paperlogoBumpin');
			logoBl.setGraphicSize(Std.int(logoBl.width * 0.2));
			logoBl.antialiasing = true;
			logoBl.animation.addByPrefix('bump', 'logo bumpin', 12);
			logoBl.animation.play('bump');
			logoBl.updateHitbox();
			// logoBl.screenCenter();
			// logoBl.color = FlxColor.BLACK;

		titlescroll = new FlxSprite(scrollset, -100).loadGraphic(Paths.image('titlescroll', 'other'));
		titlescroll.setGraphicSize(Std.int(titlescroll.width * 0.55));
		titlescroll.updateHitbox();
		titlescroll.antialiasing = true;

		clonescroll = new FlxSprite(scrollset, -100).loadGraphic(Paths.image('secondscroll', 'other'));
		clonescroll.setGraphicSize(Std.int(clonescroll.width * 0.55));
		clonescroll.updateHitbox();
		clonescroll.antialiasing = true;

		gfDance = new FlxSprite(FlxG.width * 0.4, FlxG.height * 0.07);
		gfDance.frames = Paths.getSparrowAtlas('gfDanceTitle', 'other');
		gfDance.antialiasing = true;
		gfDance.animation.addByPrefix('run', 'gfDance', 12);
		gfDance.animation.play('run');

		backgroundscroll();
		waitpls();

		titleText = new FlxSprite(100, FlxG.height * 0.8);
		titleText.frames = Paths.getSparrowAtlas('titleEnter', 'other');
		titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
		titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
		titleText.antialiasing = true;
		titleText.animation.play('idle');
		titleText.updateHitbox();
		// titleText.screenCenter(X);

		add(titlescroll);
		add(clonescroll);
		add(gfDance);
		add(logoBl);
		titleText.alpha = 0;
		add(titleText);

		var logo:FlxSprite = new FlxSprite().loadGraphic(Paths.image('logo'));
		logo.screenCenter();
		logo.antialiasing = true;
		// add(logo);

		// FlxTween.tween(logoBl, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
		// FlxTween.tween(logo, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});

		credGroup = new FlxGroup();
		add(credGroup);
		textGroup = new FlxGroup();

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		credGroup.add(blackScreen);

		credTextShit = new Alphabet(0, 0, "ninjamuffin99\nPhantomArcade\nkawaisprite\nevilsk8er", true);
		credTextShit.screenCenter();

		// credTextShit.alignment = CENTER;

		credTextShit.visible = false;

		ngSpr = new FlxSprite(0, FlxG.height * 0.52).loadGraphic(Paths.image('newgrounds_logo'));
		add(ngSpr);
		ngSpr.visible = false;
		ngSpr.setGraphicSize(Std.int(ngSpr.width * 0.8));
		ngSpr.updateHitbox();
		ngSpr.screenCenter(X);
		ngSpr.antialiasing = true;
		ngSpr.y -= 20;

		FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: PINGPONG});

		FlxG.mouse.visible = false;

		if (initialized)
			skipIntro();
		else
			initialized = true;

		// credGroup.add(credTextShit);
	}

	function getIntroTextShit():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('introText'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	var transitioning:Bool = false;
	
	// this is some shitty scrolling shite

	function waitpls()
	{
		new FlxTimer().start(14.4, function(tmr:FlxTimer)
			{	
				clonebgscroll();
			});
	}

	function backgroundscroll()
	{	
	FlxTween.tween(titlescroll, { x: -2400 }, 24); 
		new FlxTimer().start(24, function(tmr:FlxTimer)
			{
					titlescroll.x = scrollset;
			backgroundscroll();			
			});
	}

	function clonebgscroll()
	{	
			FlxTween.tween(clonescroll, { x: -2400 }, 24); 
		new FlxTimer().start(24, function(tmr:FlxTimer)
			{	
				clonescroll.x = 1400;
		clonebgscroll();
			});
	}



	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);

		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}

		if (pressedEnter && !transitioning && skippedIntro && canselect == true)
		{

			if (FlxG.save.data.flashing)
				titleText.animation.play('press');

			FlxG.camera.flash(FlxColor.WHITE, 1);
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

			transitioning = true;
			// FlxG.sound.music.stop();

			MainMenuState.firstStart = true;

				FlxTween.tween(gfDance, { x: -60 }, 0.6, {ease: FlxEase.quadInOut});
				new FlxTimer().start(0.6, function(tmr:FlxTimer)
		{
				FlxTween.tween(gfDance, { x: 2000 }, 1.4, {ease: FlxEase.quadInOut});
		});

			new FlxTimer().start(2, function(tmr:FlxTimer)
					{
						if (MainMenuState.firstStart == true)
						{
							FlxG.switchState(new WarningSubState());
						}
						else
						FlxG.switchState(new MainMenuState());
					});
		}
				
	
			// FlxG.sound.play(Paths.music('titleShoot'), 0.7);

		if (pressedEnter && !skippedIntro && initialized)
		{
			skipIntro();
		}

		super.update(elapsed);
	}

	function createCoolText(textArray:Array<String>)
	{
		for (i in 0...textArray.length)
		{
			var money:Alphabet = new Alphabet(0, 0, textArray[i], true, false);
			money.screenCenter(X);
			money.y += (i * 60) + 200;
			credGroup.add(money);
			textGroup.add(money);
		}
	}

	function addMoreText(text:String)
	{
		var coolText:Alphabet = new Alphabet(0, 0, text, true, false);
		coolText.screenCenter(X);
		coolText.y += (textGroup.length * 60) + 200;
		credGroup.add(coolText);
		textGroup.add(coolText);
	}

	function deleteCoolText()
	{
		while (textGroup.members.length > 0)
		{
			credGroup.remove(textGroup.members[0], true);
			textGroup.remove(textGroup.members[0], true);
		}
	}

	override function beatHit()
	{
		
		super.beatHit();

		logoBl.animation.play('bump');

		FlxG.log.add(curBeat);

		switch (curBeat)
		{
			case 4:
				createCoolText(['Original Game by']);
			// credTextShit.visible = true;
			case 6:
				addMoreText('ninjamuffin99');
				addMoreText('phantomArcade');
				addMoreText('kawaisprite');
				addMoreText('evilsk8er');
			// credTextShit.text += '\npresent...';
			// credTextShit.addText();
			case 7:
				deleteCoolText();
			// credTextShit.visible = false;
			// credTextShit.text = 'In association \nwith';
			// credTextShit.screenCenter();
			case 8:
					createCoolText(['Not Possible Without']);
			case 10:
					addMoreText('Newgrounds');
					ngSpr.visible = true;
			// credTextShit.text += '\nNewgrounds';
			case 11:
				deleteCoolText();
				ngSpr.visible = false;
			// credTextShit.visible = false;

			// credTextShit.text = 'Shoutouts Tom Fulp';
			// credTextShit.screenCenter();
			case 12:
				createCoolText(['Mod', 'by']);
			// credTextShit.visible = true;
			case 14:
			// there is definitely a better way to do this
				addMoreText('NinKey');
				addMoreText('Mol');
				addMoreText('LemonKing');
				addMoreText('Snak');
				addMoreText('FNF TOK Support Team');
			// credTextShit.text += '\nlmao';
			case 15:
				deleteCoolText();
			// credTextShit.visible = false;
			// credTextShit.text = "Friday";
			// credTextShit.screenCenter();
			case 16:
				addMoreText('Project');
			// credTextShit.visible = true;
			case 17:
				addMoreText('Funky');
			// credTextShit.text += '\nNight';
			case 18:
				addMoreText('Paper'); // credTextShit.text += '\nFunkin';
			case 19:
				addMoreText('DEMO II'); // credTextShit.text += '\nFunkin';

			case 20:
				skipIntro();
		}
	}


	var skippedIntro:Bool = false;

	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			remove(ngSpr);
			canselect = false;

			FlxG.camera.flash(FlxColor.WHITE, 4);
			remove(credGroup);
			skippedIntro = true;
			gfDance.x = -1200;
			logoBl.x = -800;
			new FlxTimer().start(1.5, function(tmr:FlxTimer)
		{
				FlxTween.tween(gfDance, { x: 60 }, 0.6, {ease: FlxEase.quadInOut});
			new FlxTimer().start(0.6, function(tmr:FlxTimer)
		{
				FlxTween.tween(gfDance, { x: 0 }, 0.6, {ease: FlxEase.quadInOut});
				new FlxTimer().start(1, function(tmr:FlxTimer)
		{
				canselect = true;
				FlxTween.tween(titleText, {alpha: 1}, 1, {ease: FlxEase.circOut});
				FlxTween.tween(logoBl, { x: 320 }, 0.3, {ease: FlxEase.quadInOut});
				new FlxTimer().start(0.3, function(tmr:FlxTimer)
		{
				FlxTween.tween(logoBl, { x: 300 }, 0.4, {ease: FlxEase.quadInOut});
		});
		});
		});
		});
		}
	}
}
