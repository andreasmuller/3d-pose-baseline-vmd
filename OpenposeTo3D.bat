@echo off
rem --- 
rem ---  OpenPose �� json�f�[�^���� 3D�f�[�^�ɕϊ�
rem --- 

rem ---  �J�����g�f�B���N�g�������s��ɕύX
cd /d %~dp0

rem ---  ��͌���JSON�f�B���N�g���p�X
echo Openpose�̉�͌��ʂ�JSON�f�B���N�g���̃t���p�X����͂��ĉ������B
echo ���̐ݒ�͔��p�p�����̂ݐݒ�\�ŁA�K�{���ڂł��B
set OPENPOSE_JSON=
set /P OPENPOSE_JSON=����͌���JSON�f�B���N�g���p�X: 
rem echo OPENPOSE_JSON�F%OPENPOSE_JSON%

IF /I "%OPENPOSE_JSON%" EQU "" (
    ECHO ��͌���JSON�f�B���N�g���p�X���ݒ肳��Ă��Ȃ����߁A�����𒆒f���܂��B
    EXIT /B
)

rem ---  �f���ɉf���Ă���ő�l��

echo --------------
echo �f���̉�͌��ʂ̂����A���Ԗڂ̐l������͂��邩1�n�܂�œ��͂��ĉ������B
echo �������͂����AENTER�����������ꍇ�A1�l�ڂ̉�͂ɂȂ�܂��B
set PERSON_IDX=1
set /P PERSON_IDX="����͑Ώېl��INDEX: "

rem --echo PERSON_IDX: %PERSON_IDX%


rem ---  �ڍ׃��O�L��

echo --------------
echo �ڍׂȃ��O���o�����Ayes �� no ����͂��ĉ������B
echo �������͂����AENTER�����������ꍇ�A�ʏ탍�O�ƃ��[�V�����̃A�j���[�V����GIF���o�͂��܂��B
echo �ڍ׃��O�̏ꍇ�A�e�t���[�����Ƃ̃f�o�b�O�摜���ǉ��o�͂���܂��B�i���̕����Ԃ�������܂��j
echo warn �Ǝw�肷��ƁA�A�j���[�V����GIF���o�͂��܂���B�i���̕������ł��j
set VERBOSE=2
set IS_DEBUG=no
set /P IS_DEBUG="���ڍ׃��O[yes/no/warn]: "

IF /I "%IS_DEBUG%" EQU "yes" (
    set VERBOSE=3
)

IF /I "%IS_DEBUG%" EQU "warn" (
    set VERBOSE=1
)

rem ---  python ���s
python src/openpose_3dpose_sandbox_vmd.py --camera_frame --residual --batch_norm --dropout 0.5 --max_norm --evaluateActionWise --use_sh --epochs 200 --load 4874200 --gif_fps 30 --verbose %VERBOSE% --openpose %OPENPOSE_JSON% --person_idx %PERSON_IDX%


