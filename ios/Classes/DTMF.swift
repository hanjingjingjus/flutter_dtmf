//https://github.com/palmerc/DTMFSounds

import Foundation


public typealias DTMFType = (Float, Float)
public typealias MarkSpaceType = (Float, Float)
public class DTMF
{


    public static let toneSound1 = UInt32(1200)
    public static let toneSound2 = UInt32(1201)
    public static let toneSound3 = UInt32(1202)
    public static let toneSound4 = UInt32(1203)
    public static let toneSound5 = UInt32(1204)
    public static let toneSound6 = UInt32(1205)
    public static let toneSound7 = UInt32(1206)
    public static let toneSound8 = UInt32(1207)
    public static let toneSound9 = UInt32(1208)
    public static let toneSound0 = UInt32(1209)
    public static let toneSoundStar = UInt32(1210)
    public static let toneSoundPound = UInt32(1211)
    public static let toneSoundCallWaiting = UInt32(1256)


    public static let tone1     = DTMFType(800.0, 800.0)
    public static let tone2     = DTMFType(1336.0, 697.0)
    public static let tone3     = DTMFType(1477.0, 697.0)
    public static let tone4     = DTMFType(1209.0, 770.0)
    public static let tone5     = DTMFType(1336.0, 770.0)
    public static let tone6     = DTMFType(1477.0, 770.0)
    public static let tone7     = DTMFType(1209.0, 852.0)
    public static let tone8     = DTMFType(1336.0, 852.0)
    public static let tone9     = DTMFType(1477.0, 852.0)
    public static let tone0     = DTMFType(1336.0, 941.0)
    public static let toneStar  = DTMFType(1209.0, 941.0)
    public static let tonePound = DTMFType(1477.0, 941.0)
    public static let toneA     = DTMFType(1633.0, 697.0)
    public static let toneB     = DTMFType(1633.0, 770.0)
    public static let toneC     = DTMFType(1633.0, 852.0)
    public static let toneD     = DTMFType(1633.0, 941.0)
    public static let toneCallWaiting     = DTMFType(440.0, 480.0)
    public static let playCallAlert     = DTMFType(350.0, 440.0)
    public static let playCallTerm     = DTMFType(425.0, 425.0)

    public static let standard  = MarkSpaceType(40.0, 40.0)
    public static let motorola  = MarkSpaceType(250.0, 250.0)
    public static let whelen    = MarkSpaceType(40.0, 20.0)
    public static let fast      = MarkSpaceType(20.0, 20.0)
    public static let long  = MarkSpaceType(1000.0, 40.0)
    public static let middle  = MarkSpaceType(200.0, 40.0)
    public static let short  = MarkSpaceType(100.0, 40.0)



    /**
     Generates a series of Float samples representing a DTMF tone with a given mark and space.

     - parameter DTMF: takes a DTMFType comprised of two floats that represent the desired tone frequencies in Hz.
     - parameter markSpace: takes a MarkSpaceType comprised of two floats representing the duration of each in milliseconds. The mark represents the length of the tone and space the silence.
     - parameter sampleRate: the number of samples per second (Hz) desired.
     - returns: An array of Float that contains the Linear PCM samples that can be fed to AVAudio.
     */
    public static func generateDTMF(_ DTMF: DTMFType, markSpace: MarkSpaceType = motorola, sampleRate: Float = 44100.0) -> [Float]
    {
        let toneLengthInSamples = 10e-4 * markSpace.0 * sampleRate
        let silenceLengthInSamples = 10e-4 * markSpace.1 * sampleRate

        var sound = [Float](repeating: 0, count: Int(toneLengthInSamples + silenceLengthInSamples))
        let twoPI:Float = 2.0 * .pi

        for i in 0 ..< Int(toneLengthInSamples) {
            // Add first tone at half volume
            let sample1 = 0.5 * sin(Float(i) * twoPI / (sampleRate / DTMF.0));

            // Add second tone at half volume
            let sample2 = 0.5 * sin(Float(i) * twoPI / (sampleRate / DTMF.1));

            sound[i] = sample1 + sample2
        }

        return sound
    }
}

extension DTMF
{
    enum characterForTone: Character {
        case tone1     = "1"
        case tone2     = "2"
        case tone3     = "3"
        case tone4     = "4"
        case tone5     = "5"
        case tone6     = "6"
        case tone7     = "7"
        case tone8     = "8"
        case tone9     = "9"
        case tone0     = "0"
        case toneA     = "A"
        case toneB     = "B"
        case toneC     = "C"
        case toneD     = "D"
        case toneStar  = "*"
        case tonePound = "#"
        case toneCallWaiting = "X"
        case playCallAlert = "Y"
        case playCallTerm = "Z"
    }
    enum stringForToneSound: String {
          case tone1     = "1"
          case tone2     = "2"
          case tone3     = "3"
          case tone4     = "4"
          case tone5     = "5"
          case tone6     = "6"
          case tone7     = "7"
          case tone8     = "8"
          case tone9     = "9"
          case tone0     = "0"
          case toneA     = "A"
          case toneB     = "B"
          case toneC     = "C"
          case toneD     = "D"
          case toneStar  = "*"
          case tonePound = "#"
          case toneCallWaiting = "X"
          case playCallAlert = "Y"
          case playCallTerm = "Z"
      }

    public static func toneForCharacter(character: Character) -> DTMFType?
    {
        var tone: DTMFType?
        switch (character) {
        case characterForTone.tone1.rawValue:
            tone = DTMF.tone1
            break
        case characterForTone.tone2.rawValue:
            tone = DTMF.tone2
            break
        case characterForTone.tone3.rawValue:
            tone = DTMF.tone3
            break
        case characterForTone.tone4.rawValue:
            tone = DTMF.tone4
            break
        case characterForTone.tone5.rawValue:
            tone = DTMF.tone5
            break
        case characterForTone.tone6.rawValue:
            tone = DTMF.tone6
            break
        case characterForTone.tone7.rawValue:
            tone = DTMF.tone7
            break
        case characterForTone.tone8.rawValue:
            tone = DTMF.tone8
            break
        case characterForTone.tone9.rawValue:
            tone = DTMF.tone9
            break
        case characterForTone.tone0.rawValue:
            tone = DTMF.tone0
            break
        case characterForTone.toneA.rawValue:
            tone = DTMF.toneA
            break
        case characterForTone.toneB.rawValue:
            tone = DTMF.toneB
            break
        case characterForTone.toneC.rawValue:
            tone = DTMF.toneC
            break
        case characterForTone.toneD.rawValue:
            tone = DTMF.toneD
            break
        case characterForTone.toneStar.rawValue:
            tone = DTMF.toneStar
            break
        case characterForTone.tonePound.rawValue:
            tone = DTMF.tonePound
            break
        case characterForTone.toneCallWaiting.rawValue:
            tone = DTMF.toneCallWaiting
            break
        case characterForTone.playCallAlert.rawValue:
            tone = DTMF.playCallAlert
            break
        case characterForTone.playCallTerm.rawValue:
            tone = DTMF.playCallTerm
            break
        default:
            break
        }

        return tone
    }

    public static func tonesForString(_ string: String) -> [DTMFType]?
    {
        var tones = [DTMFType]()
        for character in string {
            if let tone = DTMF.toneForCharacter(character: character) {
                tones.append(tone)
            }
        }

        return tones.count > 0 ? tones : nil
    }


    public static func toneSoundForString(stringForTone: String) -> UInt32?
      {
          var tone: UInt32?
          switch (stringForTone) {
          case stringForToneSound.tone1.rawValue:
              tone = DTMF.toneSound1
              break
          case stringForToneSound.tone2.rawValue:
              tone = DTMF.toneSound2
              break
          case stringForToneSound.tone3.rawValue:
              tone = DTMF.toneSound3
              break
          case stringForToneSound.tone4.rawValue:
              tone = DTMF.toneSound4
              break
          case stringForToneSound.tone5.rawValue:
              tone = DTMF.toneSound5
              break
          case stringForToneSound.tone6.rawValue:
              tone = DTMF.toneSound6
              break
          case stringForToneSound.tone7.rawValue:
              tone = DTMF.toneSound7
              break
          case stringForToneSound.tone8.rawValue:
              tone = DTMF.toneSound8
              break
          case stringForToneSound.tone9.rawValue:
              tone = DTMF.toneSound9
              break
          case stringForToneSound.tone0.rawValue:
              tone = DTMF.toneSound0
              break
//          case characterForTone.toneA.rawValue:
//              tone = DTMF.toneA
//              break
//          case characterForTone.toneB.rawValue:
//              tone = DTMF.toneB
//              break
//          case characterForTone.toneC.rawValue:
//              tone = DTMF.toneC
//              break
//          case characterForTone.toneD.rawValue:
//              tone = DTMF.toneD
//              break
          case stringForToneSound.toneStar.rawValue:
              tone = DTMF.toneSoundStar
              break
          case stringForToneSound.tonePound.rawValue:
              tone = DTMF.toneSoundPound
              break
          case stringForToneSound.toneCallWaiting.rawValue:
              tone = DTMF.toneSoundCallWaiting
              break
//          case characterForTone.playCallAlert.rawValue:
//              tone = DTMF.playCallAlert
//              break
//          case characterForTone.playCallTerm.rawValue:
//              tone = DTMF.playCallTerm
//              break
          default:
              break
          }

          return tone
      }

}
