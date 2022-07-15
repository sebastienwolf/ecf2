<?php

namespace Controllers;

use stdClass;

class Question extends Controller
{

    protected $modelName = \Models\Question::class;

    // ===================================================================================================
    // ===============================        showForumulaire    ===========================================
    // ===================================================================================================
    public function showForumulaire()
    {
        $object = new stdClass();
        $category = 1;
        $this->model->takeTheQuestionsAndAnswer($object, $category);
        $this->formatTheObject($object);

        $pageTitle = 'formulaire';
        \Renderer::render('articles/formulaire', compact('pageTitle', 'object'));
    }
    // ===================================================================================================
    // ===============================        format the object    ===========================================
    // ===================================================================================================
    public function formatTheObject($object)
    {
        $keyIndexQuestion = 0;
        $object->question = [];
        $object->question[1] = [];

        foreach ($object->all as $value) {
            if (!isset($object->question[$keyIndexQuestion]) || in_array($value['question'], $object->question[$keyIndexQuestion]) !== true) {
                $keyIndexQuestion++;
                $object->question[$keyIndexQuestion] = ['label' => $value['question'], 'answer' => []];
                $keyIndexAnswer = 0;
            }
            $object->question[$keyIndexQuestion]['answer'][$keyIndexAnswer] = ['label' => $value['label'], 'id' => $value['id'], 'type' => $value['type']];
            $keyIndexAnswer++;
        }
    }
}
