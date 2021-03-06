    Keywords: IBM ENHANCED GRAPHICS ADAPTER EGA BIOS INTERFACE ROUTINES

    This file contains "underground" undocumented BIOS interface routines as
    submitted by Joel Seiferas for the IBM Enhanced Graphics Adapter.
    Hopefully, IBM will come up with "official" documentation shortly, but
    this may help until that time.


The following is a concantenation of the messages from Joel Seiferas,
70516,1704 concerning the IBM Enhanced Graphics Adapter and its BIOS
interfaces.  Hopefully, this will help until IBM releases "official"
information....


 #: 80780      Sub-topic 1 - User Updates/Fixes
Sb: EGA doc.
    26-Dec-84  19:01:04
Fm: Joel Seiferas   70516,1704
To: EGA owners


     The IBM Enhanced Graphics Adapter is comes without usage
instructions, so the following message should be useful to purchasers.

Date: Fri, 21 Dec 84 22:50:00 EST
From: BrucCowan%UMich-MTS.Mailnet@MIT-MULTICS.ARPA
Subject: IBM Enhanced Graphics Adaptor Information

Here are some very brief instructions for the BIOS interface for the
enhanced graphics adaptor. No guarantees about accuracy. Hope they are
of some use. I haven't figured out most of them. Parenthesized comments
indicate some things I have found out. I'd like any more information
anyone comes up with.

EGA extensions to ROM BIOS INT 10H.

(AH)=0 Set mode
  (AL) 0-7 as before (7 is now user selectable)
       D  graphics 320x200 on color (5153) monitor
       E  graphics 640x200
       F  graphics 640x350 on monochrome monitor
      10  graphics 640x350 on 5154 monitor
     All above have graphics memory at A000:0. If you use one of the
     old modes, the memory appears at the standard address for the
     old adaptors (B000:0 or B800:0).

(AH)=10 Set palette registers
  (AL)=0 Set individual palette register
    BL = palette register to set, BH = value to set
  (AL)=1 Set overscan register
    BH = value to set
  (AL)=2 Set all palette registers and overscan
    ES:DX points to a 17 byte table
    bytes 0-15 are the palette values, respectively
    byte 16 is the overscan value
  (AL)=3 Toggle intensify/blinking bit
    BL - 0 enable intensify
    BL - 1 enable blinking

(AH)=11 Character generator routine
        Note: This call will initiate a mode set.
  (AL)=00 User alpha load
        ES:BP - pointer to user table
        CX    - count to store
        DX    - character offset into table
        BL    - block to load
        BH    - number of bytes per character
  (AL)=01 ROM monochrome set
        BL    - block to load
  (AL)=02 ROM 8x8 double dot
        BL    - block to load
  (AL)=03 Set block specifier
        BL    - char gen block specifier
                D3-D2 attr bit 3 one, char gen 0-3
                D1-D0 attr bit 3 zero, char gen 0-3
        Note: When using AL=03, a function call AX=1000H, BX=0712H is
              recommended to set the color planes resulting in 512
              characters and 8 consistent colors.

  Note: The following interface (AL=1x) is similar in function to
        (AL=0x) except that:
                - page 0 must be active
                - points (bytes/char) will be recalculated
                - rows will be calculated from the following:
                        int (200 or 350) / points - 1
                - CRLEN will be calculated from:
                        (rows+1)*CRCOLS*2
                - the CRTC will be reprogrammed as follows:
                        R09H = points - 1    max scan line
                                R09H only done in mode 7
                        R0AH = points - 2    cursor start
                        R0BH = 0             cursor end
                        R12H =               vert disp end
                               (rows+1)*points-1
                        R14H = points        underline loc
        The above register calculations must be close to the original
        table values or undetermined results will occur.

        Note: The following interface is designed to be called only
              immediately after a mode set. Failure to adhere to this
              practice may cause undetermined results.

  (AL)=10 User alpha load
        ES:BP - pointer to user table
        CX    - count to store
        DX    - character offset into table
        BL    - block to load
        BH    - number of bytes per character
  (AL)=11 ROM monochrome set
        BL    - block to load
  (AL)=12 ROM 8x8 double dot
        BL    - block to load  (this gives 43 lines in char mode)

        Note: The following interface is designed to be called only
              immediately after a mode set. Failure to adhere to this
              practice may cause undetermined results.
  (AL)=20 User graphics chars  INT 01FH (8x8)
        ES:BP - pointer to user table
  (AL)=21 User graphics chars
        ES:BP - pointer to user table
        CX    - points (bytes/char)
        BL    - row specifier
                BL = 0 user
                       DL - rows
                BL = 1 14 (0EH)
                BL = 2 25
                BL = 3 43
  (AL)=22 ROM 8x14 set
        BL    - row specifier
  (AL)=23 ROM 8x8 double dot
        BL    - row specifier (this seems wrong, use BL=# rows)

  (AL)=30 Information
                CX - points
                DL - rows
        BH - 0 return current INT 1FH ptr
                ES:BP - ptr to table
        BH - 1 return current INT 44H ptr
                ES:BP - ptr to table
        BH - 2 return ROM 8x14 ptr
                ES:BP - ptr to table
        BH - 3 return ROM double dot
                ES:BP - ptr to table
        BH - 4 return ROM double dot (top)
                ES:BP - ptr to table
        BH - 5 return ROM alpha alternate 9x14
                ES:BP - ptr to table

(AH)=12 Alternate select
  (BL)=10 Return EGA information
        BH = 0 - color mode in effect
           = 1 - monochrome mode in effect
        BL = memory value
                0 0 - 064K        0 1 - 128K
                1 0 - 192K        1 1 - 256K
        CH = feature bits
        CL = switch setting
  (BL)=20 Select alternate print screen routine

(AH)=13 Write string
  This is the same as documented in the PC/AT Technical Reference
  BIOS listing (but is new for non ATs).
AH)=13 Write string
  This is the same as documented 

                                                                                         