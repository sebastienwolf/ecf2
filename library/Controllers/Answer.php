<?php

namespace Controllers;

use stdClass;

class Answer extends Controller
{

    protected $modelName = \Models\Answer::class;

    // ===================================================================================================
    // ==============================        resultOfTheForm    ==========================================
    // ===================================================================================================

    public function resultOfTheForm()
    {
        $object = json_decode($_POST['formulaire']);

        $this->filterInformation($object);
        $this->takeTheSolutions($object);
        $this->takeIdCompany($object);
        $this->makeTheScore($object);
        $this->chooseTheWinner($object);
        $this->insertQuestionAndAnswersOnWinner($object);

        //Toutes les informations sont sauvegardées pour que l'entreprise puisse par le futur
        //mettre en place un Salesforce qui va permettre de stocker les informations utilisateur. 
        //Cela permettra de créer des tickets de personnes à contacter par l'équipe commercial.

        echo json_encode($object);
    }
    // ===================================================================================================
    // ============================        filterInformation    ==========================================
    // ===================================================================================================
    public function filterInformation($object)
    {
        $firstName = htmlspecialchars($object->firstName);
        $name = htmlspecialchars($object->name);
        $telephone = htmlspecialchars($object->telephone);
        $association = htmlspecialchars($object->association);
        $mail = filter_var($object->mail, FILTER_SANITIZE_EMAIL);
        $typeCompany = $object->answer[0];

        $object->firstName =  $firstName;
        $object->name = $name;
        $object->telephone = $telephone;
        $object->association = $association;
        $object->mail = $mail;
        $object->industry = $typeCompany;

        return $object;
    }

    // ===================================================================================================
    // ===============================        takeTheSolutions    ========================================
    // ===================================================================================================
    public function takeTheSolutions($object)
    {
        $keyIndex = 0;
        $answer = filter_var_array($object->answer, FILTER_SANITIZE_NUMBER_INT);


        foreach ($answer as $value) {
            $solution = $this->model->solution($value);
            $object->answer[$keyIndex] = ['answer' => $value, 'solution' => $solution];

            $this->insertTypeAssociation($value, $object, $keyIndex);

            $keyIndex++;
        }

        return $object;
    }
    // ===================================================================================================
    // ===============================        insertTypeAssociation    ===================================
    // ===================================================================================================
    public function insertTypeAssociation($idAnswer, $object, $keyIndex)
    {

        if ($object->industry === $idAnswer) {
            $object->industry = $object->answer[$keyIndex]['solution'][0]['label'];
        }
        return $object;
    }

    // ===================================================================================================
    // ===============================        takeIdCompany    ===========================================
    // ===================================================================================================
    public function takeIdCompany($object)
    {
        foreach ($object->answer[0]['solution'] as $value) {
            $object->score[$value['solution_id']] = ['id' => $value['solution_id'], 'score' => 0];
        }


        return $object;
    }

    // ===================================================================================================
    // ================================        makeTheScore    ===========================================
    // ===================================================================================================
    public function makeTheScore($object)
    {
        foreach ($object->answer as $value) {
            foreach ($value['solution'] as $scoringSolution) {

                $scoring = $scoringSolution['score'] * $scoringSolution['coefficient'];
                $idSolution = $scoringSolution['solution_id'];
                $object->score[$idSolution]['score'] = $object->score[$idSolution]['score'] + $scoring;
            }
        }

        return $object;
    }
    // ===================================================================================================
    // =============================        chooseTheWinner    ===========================================
    // ===================================================================================================
    public function chooseTheWinner($object)
    {
        $takeTheScores = [];
        $podium = ["first", "second", "third"];

        foreach ($object->score as $value) {
            $takeTheScores[$value['id']] = $value['score'];
        }
        arsort($takeTheScores);
        $keyIndex = array_keys($takeTheScores);

        for ($i = 0; $i < 3; $i++) {
            $object->winner['podium'][$podium[$i]] = $this->model->winner($keyIndex[$i]);
            $object->winner['score'] = $takeTheScores;
        }



        return $object;
    }
    // ===================================================================================================
    // ======================        createKeyIndexForPodium    =================================
    // ===================================================================================================

    public function createKeyIndexForPodium($takeTheScores)
    {

        $idSolutionForPodium = [];

        foreach ($takeTheScores as $value) {
            array_push($idSolutionForPodium, $value);
        }
    }


    // ===================================================================================================
    // ======================        insertQuestionAndAnswersOnWinner    =================================
    // ===================================================================================================
    public function insertQuestionAndAnswersOnWinner($object)
    {
        $keyIndex = 0;

        foreach ($object->answer as $value) {
            $object->winner['question'][$keyIndex] = [];
            array_push($object->winner['question'][$keyIndex], $value['solution'][0]['question'], $value['solution'][0]['label']);

            $keyIndex++;
        }

        return $object;
    }
}
